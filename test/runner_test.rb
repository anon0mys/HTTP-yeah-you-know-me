require_relative 'test_helper'
require 'net/http'
require './lib/runner'

# Tests runner class
class ServerTest < Minitest::Test
  def test_runner_initializes_server
    # skip
    runner = Runner.new
    runner.run

    assert_instance_of Server, runner.server
    runner.server.tcp_server.close
  end

  def test_runner_counts_requests
    # skip
    runner = Runner.new
    assert_equal 0, runner.requests

    runner.run
    assert_equal 2, runner.requests

    runner.server.tcp_server.close
  end
end
