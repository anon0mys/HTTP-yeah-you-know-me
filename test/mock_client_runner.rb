require_relative 'test_helper'
require_relative 'mock_client.rb'
require './lib/runner'

# Tests runner class
class ServerTest < Minitest::Test
  def test_server_responds_hello_world
    client = MockClient.new
    client.get

    assert client.response.body.include?('Hello, World! (1)')

    client.get
    assert client.response.body.include?('Hello, World! (2)')
  end

  def test_server_responds_with_diagnostics
    skip
  end
end
