require 'test_helper'
require 'stringio'

class Rack::Verify::Line::BotTest < Test::Unit::TestCase
  include Rack::Test::Methods

  PAYLOAD = StringIO.new(%q({"events":[{"type":"message","replyToken":"75e6cb6a6dc14b2c8d25eb1fda06bc6c","source":{"userId":"Ua20fb80218abd1686411dec7f2b977a0","type":"user"},"timestamp":1481632823600,"message":{"type":"text","id":"5344013044158","text":"test"}}]}))

  VALID_SIGNATURE   = 'dX6QKJqcdyDfyi3k6LQwO65nEZR5ZLr0djyccy3iayA='
  INVALID_SIGNATURE = 'InvalidSignatureInvalidSignatureInvalidSign='

  def app
    bare_app = ->(env) {
      [ 204, [], [] ]
    }

    Rack::Verify::Line::Bot.new(
      bare_app,
      :secret => '80eb366d64ab27645880b808ca672635',
      :path   => '/webhook',
    )
  end

  def test_get
    get '/'

    assert last_response.successful?
  end

  def test_post_to_non_webhook
    post '/', PAYLOAD, {
      'CONTENT_TYPE'          => 'application/json;charset=UTF-8',
      'CONTENT_LENGTH'        => PAYLOAD.length.to_s,
      'HTTP_X_LINE_SIGNATURE' => INVALID_SIGNATURE,
    }

    assert last_response.successful?
  end

  def test_without_signature
    post '/webhook', PAYLOAD, {
      'CONTENT_TYPE'          => 'application/json;charset=UTF-8',
      'CONTENT_LENGTH'        => PAYLOAD.length.to_s,
    }

    assert last_response.bad_request?
  end

  def test_with_invalid_signature
    post '/webhook', PAYLOAD, {
      'CONTENT_TYPE'          => 'application/json;charset=UTF-8',
      'CONTENT_LENGTH'        => PAYLOAD.length.to_s,
      'HTTP_X_LINE_SIGNATURE' => INVALID_SIGNATURE,
    }

    assert last_response.bad_request?
  end

  def test_with_valid_signature
    post '/webhook', PAYLOAD, {
      'CONTENT_TYPE'          => 'application/json;charset=UTF-8',
      'CONTENT_LENGTH'        => PAYLOAD.length.to_s,
      'HTTP_X_LINE_SIGNATURE' => VALID_SIGNATURE,
    }

    assert last_response.successful?
  end
end
