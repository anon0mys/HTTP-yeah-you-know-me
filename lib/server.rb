require 'socket'

# Server class for listenening and accessing database
class Server
  attr_reader :tcp_server, :client
  def initialize
    @tcp_server = TCPServer.new(9292)
    @client = nil
  end

  def request_getter
    @client = @tcp_server.accept
    @client.gets
  end
end
