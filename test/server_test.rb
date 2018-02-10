require_relative 'test_helper'
require './lib/server'

# Tests sever class
class ServerTest < Minitest::Test
  def test_server_initializes_and_returns_request
    server = Server.new

    assert_instance_of Server, server
    assert_instance_of TCPServer, server.tcp_server

    server.tcp_server.close
  end

  def test_request_getter_returns_request
    server = Server.new

    refute server.request_getter.nil?

    server.tcp_server.close
  end
end
