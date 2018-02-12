require_relative 'server'

# Runner class for handling server requests and responses
class Runner
  attr_reader :server, :requests

  def initialize
    @server = Server.new
    @requests = 0
  end

  def run
    loop do
      @server.request_getter
      @requests += 1
      response
      @server.client.close
      break if @requests == 2
    end
  end

  def response
    response = '<pre>' + "Hello, World! (#{@requests})" + '</pre>'
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ['http/1.1 200 ok',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @server.client.puts headers
    @server.client.puts output
  end
end
