require_relative 'test_helper'
require './lib/runner'

# Tests runner class
class ServerTest < Minitest::Test
  def test_runner_initializes_server
    skip
    runner = Runner.new
    assert_instance_of Server, runner.server
  end

  def test_runner_counts_requests
    skip
    runner = Runner.new
    assert_equal 0, runner.requests

    runner.run # Change from external request to mock
    assert_equal 1, runner.requests

    runner.run # Change from external request to mock
    assert_equal 2, runner.requests
  end
end
