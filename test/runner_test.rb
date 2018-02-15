require_relative 'test_helper'
require './lib/runner'

# Tests runner class
class RunnerTest < Minitest::Test
  def test_runner_initializes_server_with_no_requests
    # skip
    runner = Runner.new
    assert_equal 0, runner.requests
    runner.run

    assert_instance_of Server, runner.server
  end
end
