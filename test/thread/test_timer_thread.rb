require 'test/unit'
require 'thread'

class TestTimerThread < Test::Unit::TestCase
  def number_of_lwps
    `ps -o nlwp #{Process.pid} | tail -n1`.strip.to_i
  end

  def test_timer_is_created_and_destroyed
    # TODO: enable this test on other platforms
    return if /linux/ !~ RUBY_PLATFORM

    assert_equal 1, number_of_lwps

    th = Thread.new { sleep 0.1 }
    assert_equal 3, number_of_lwps

    th.join
    assert_equal 1, number_of_lwps
  end
end
