require './lib/server'
require './lib/request_parser'
require './lib/router'
require 'pry'

# Runner class for mediating requests and responses
class Runner
  attr_reader :server, :requests

  def initialize
    @server = Server.new
    @router = Router.new
    @requests = 0
    @current_path = nil
  end

  def run
    loop do
      return @server.tcp_server.close if @current_path == '/shutdown'
      request_lines = @server.request_getter
      @requests += 1
      response(request_lines)
      @server.client.close
    end
  end

  def response(request_lines)
    diagnostics = build_diagnostics(request_lines)
    output = @router.respond(diagnostics, @requests)
    @server.client.puts output[:headers]
    @server.client.puts output[:body]
  end

  def build_diagnostics(request_lines)
    parser = RequestParser.new
    parser.diagnostics_parser(request_lines)
    @current_path = parser.diagnostics['Path:']
    parser.diagnostics
  end
end
