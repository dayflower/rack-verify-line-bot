# Rack::Verify::Line::Bot

[![CircleCI](https://circleci.com/gh/dayflower/rack-verify-line-bot.svg?style=svg)](https://circleci.com/gh/dayflower/rack-verify-line-bot)

Rack middleware which verifies signature of LINE Bot's webhook requests to ensure the hook is invoked from LINE.

## Usage

```ruby
# config.ru
require 'rack/verify/line/bot'

use Rack::Verify::Line::Bot, :secret => ENV['SECRET'],  # channel secret (mandatory)
                             :path   => '/hook'         # path of webhook URI
```

### Options

- `:secret`
  Specify channel secret.  This option is mandatory.
- `:path`
  Specify path component of webhook URL.  If omitted, every POST requests will be examined.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-verify-line-bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-verify-line-bot

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
