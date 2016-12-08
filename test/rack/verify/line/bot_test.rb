require 'test_helper'

class Rack::Verify::Line::BotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rack::Verify::Line::Bot::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
