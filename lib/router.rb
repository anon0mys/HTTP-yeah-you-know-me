require './lib/paths/root'
require './lib/paths/hello'
require './lib/paths/datetime'
require './lib/paths/shutdown'
require './lib/paths/word_search'

# Determines path based on diagnostics hash parsed by diagnostics_parser
class Router
  attr_reader :path

  def initialize
    @paths = {
      '/' => 'Root',
      '/hello' => 'Hello',
      '/datetime' => 'DatePath',
      '/shutdown' => 'Shutdown',
      '/word_search' => 'WordSearch'
    }
    @endpoint = nil
    @hello_requests = 0
  end

  def assign_endpoint(path, requests)
    if path == '/hello'
      @hello_requests += 1
      requests = @hello_requests
    end
    @endpoint = Object.const_get(@paths[path]).new(requests)
  end

  def respond(diagnostics, requests)
    assign_endpoint(diagnostics['Path:'], requests)
    body = @endpoint.body(diagnostics)
    { headers: @endpoint.headers(body.length),
      body: body }
  end
end
