# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/verify/line/bot/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-verify-line-bot"
  spec.version       = Rack::Verify::Line::Bot::VERSION
  spec.authors       = ["dayflower"]
  spec.email         = ["daydream.trippers@gmail.com"]

  spec.summary       = %q{Rack middleware for verifying signature of LINE Bot callback}
  spec.description   = %q{Rack middleware for verifying signature of LINE Bot callback}
  spec.homepage      = "https://github.com/dayflower/rack-verify-line-bot"
  spec.license       = "MIT"

  spec.files         = %w[
    Gemfile
    LICENSE.txt
    README.md
    Rakefile
    bin/console
    bin/setup
    lib/rack-verify-line-bot.rb
    lib/rack/verify/line/bot.rb
    lib/rack/verify/line/bot/version.rb
    rack-verify-line-bot.gemspec
  ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", ">= 3.0"
  spec.add_development_dependency "rack", "~> 1"
  spec.add_development_dependency "rack-test", "~> 0.6"
end
