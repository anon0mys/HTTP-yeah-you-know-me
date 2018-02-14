require './lib/server'
require './lib/router'
require './lib/request_parser'
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
    body = Router.body(@requests, diagnostics(request_lines))
    @server.client.puts Router.headers(body.length)
    @server.client.puts body
  end

  def diagnostics(request_lines)
    parser = RequestParser.new
    parser.diagnostics_parser(request_lines)
    parser.print_diagnostics
  end
end
