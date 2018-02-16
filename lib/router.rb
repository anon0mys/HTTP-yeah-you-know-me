require './lib/paths/root'
require './lib/paths/hello'
require './lib/paths/datetime'
require './lib/paths/shutdown'
require './lib/paths/word_search'
require './lib/paths/game'
require 'pry'

# Determines path based on diagnostics hash parsed by diagnostics_parser
class Router
  attr_reader :endpoint, :current_game

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
    @current_game = nil
  end

  def find_path(diagnostics, requests, content)
    path = diagnostics['Path:']
    if path == '/hello'
      @hello_requests += 1
      assign_endpoint(path, @hello_requests)
    elsif %w[/game /start_game].include?(path)
      game(diagnostics, content)
    else
      assign_endpoint(path, requests)
    end
  end

  def assign_endpoint(path, requests)
    @endpoint = Object.const_get(@paths[path]).new(requests)
  end

  def respond(diagnostics, requests, content = nil)
    find_path(diagnostics, requests, content)
    redirect?(diagnostics)
  end

  def game(diagnostics, content)
    if diagnostics['Path:'] == '/start_game'
      @current_game = Game.new
      @endpoint = @current_game
    elsif diagnostics['Verb:'] == 'POST'
      @endpoint.play(content)
    else
      @endpoint = @current_game
    end
  end

  def build_response(diagnostics)
    body = @endpoint.body(diagnostics)
    { headers: @endpoint.headers(body.length).join("\r\n"),
      body: body }
  end

  def redirect?(diagnostics, response_code = '302 Found')
    if diagnostics['Verb:'] == 'GET' || diagnostics['Path:'] == '/start_game'
      build_response(diagnostics)
    else
      redirect_header = @endpoint.headers(0, response_code)
      redirect_header.insert(1, 'Location: http://127.0.0.1:9292/game')
      { headers: redirect_header.join("\r\n"), body: nil }
    end
  end
end
