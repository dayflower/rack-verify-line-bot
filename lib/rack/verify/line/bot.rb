require "rack/verify/line/bot/version"
require "openssl"
require "base64"

module Rack
  module Verify
    module Line
      class Bot
        def initialize(app, options = {})
          @app = app
          @options = options

          @secret = @options[:secret]
          unless @secret
            raise 'missing secret parameter for ' + self.class.name
          end

          @buffer_size = @options[:buffer_size] || 65536
        end

        def call(env)
          if need_verification?(env)
            unless verify_signature(env)
              return [
                400,
                {
                  'Content-Type'   => 'text/plain',
                  'Content-Length' => '11',
                },
                [ 'Bad Request' ]
              ]
            end
          end

          @app.call(env)
        end

        private

        SIGNATURE_HEADER = 'HTTP_X_LINE_SIGNATURE'

        def need_verification?(env)
          return false unless env['REQUEST_METHOD'].upcase == 'POST'

          if @options[:path]
            return false unless env['PATH_INFO'] == @options[:path]
          end

          return true
        end

        def verify_signature(env)
          given_sig = env[SIGNATURE_HEADER]
          return false unless given_sig

          hmac = OpenSSL::HMAC.new(@secret, OpenSSL::Digest::SHA256.new)
          update_hmac(hmac, env['rack.input'])
          sig = Base64.strict_encode64(hmac.digest)

          secure_compare(given_sig, sig)
        end

        # from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/security_utils.rb
        # Rails is released under MIT license
        def secure_compare(a, b)
          return false unless a.bytesize == b.bytesize

          l = a.unpack "C#{a.bytesize}"

          res = 0
          b.each_byte { |byte| res |= byte ^ l.shift }
          res == 0
        end

        def update_hmac(hmac, handle)
          return unless handle

          handle.rewind
          begin
            buffer = ''
            while handle.read(@buffer_size, buffer)
              hmac.update(buffer)
            end

            hmac
          ensure
            handle.rewind
          end
        end
      end
    end
  end
end
