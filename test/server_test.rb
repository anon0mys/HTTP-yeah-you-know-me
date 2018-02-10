require_relative 'test_helper'
require './lib/server'

# Tests sever class
class ServerTest < Minitest::Test
  def test_server_initializes_and_returns_request
    server = Server.new

    assert_instance_of Server, server
    assert_instance_of TCPServer, server.tcp_server
    refute server.request_getter.nil?
  end
end
