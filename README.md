# Rack::Verify::Line::Bot

## Usage

```ruby
# config.ru
require 'rack/verify/line/bot'

use Rack::Verify::Line::Bot :secret => ENV['SECRET'],   # channel secret (mandatory)
                            :path   => '/hook'          # path of webhook URI
```

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

