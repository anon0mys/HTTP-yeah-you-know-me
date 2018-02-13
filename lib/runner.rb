require_relative 'server'
require_relative 'parser'
require 'pry'

# Runner class for handling server requests and responses
class Runner
  attr_reader :server, :requests

  def initialize
    @server = Server.new
    @requests = 0
  end

  def run
    loop do
      request_lines = @server.request_getter
      @requests += 1
      response(request_lines)
      @server.client.close
      break if @requests == 2
    end
  end

  def response(request_lines)
    output = RequestParser.output(@requests)
    @server.client.puts RequestParser.headers(output.length)
    @server.client.puts output
  end
end
