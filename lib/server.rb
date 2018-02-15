require 'socket'

# Server class for receiving client requests
class Server
  attr_reader :tcp_server, :client

  def initialize(port = 9292)
    @tcp_server = TCPServer.new(port)
    @tcp_server.listen(1)
    @client = nil
  end

  def request_getter
    @client = @tcp_server.accept
    request_lines = []
    while (line = @client.gets) and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end
end
