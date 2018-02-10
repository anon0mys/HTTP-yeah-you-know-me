require 'socket'

# Server class for listenening and accessing database
class Server
  attr_reader :tcp_server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @client = @tcp_server.accept
    request
  end

  def request
    @client.gets
  end
end
