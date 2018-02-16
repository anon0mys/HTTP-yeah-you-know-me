require_relative 'test_helper'
require './lib/runner'

# Tests runner class
class RunnerTest < Minitest::Test
  include TestHelper

  def test_runner_initializes_server_with_no_requests
    # skip
    runner = Runner.new
    assert_equal 0, runner.requests
    runner.run

    assert_instance_of Server, runner.server
  end

  def test_build_diagnostics
    runner = Runner.new
    expected = runner.build_diagnostics(stub_get_lines('/'))

    assert_equal expected, stub_diagnostics('/')
    assert_equal '/', runner.current_path
    runner.server.tcp_server.close
  end
end
