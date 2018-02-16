require './lib/paths/root'
require './lib/paths/hello'
require './lib/paths/datetime'
require './lib/paths/shutdown'
require './lib/paths/word_search'
require './lib/paths/game'
require './lib/paths/force_error'
require './lib/response'
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
      '/word_search' => 'WordSearch',
      '/force_error' => 'ForceError'
    }
    @endpoint = Response.new(0)
    @hello_requests = 0
    @current_game = nil
  end

  def find_path(diagnostics, requests, content)
    path = diagnostics['Path:']
    if path == '/hello'
      assign_endpoint(path, @hello_requests += 1)
    elsif %w[/game /start_game].include?(path)
      game(diagnostics, content)
    else
      return '404 Not Found' unless @paths.include?(path)
      assign_endpoint(path, requests)
    end
  end

  def assign_endpoint(path, requests)
    @endpoint = Object.const_get(@paths[path]).new(requests)
  end

  def respond(diagnostics, requests, content = nil)
    redirects = ['301 Moved Permanently', '302 Found',
                 '403 Forbidden', '404 Not Found']
    path = find_path(diagnostics, requests, content)
    if redirects.include?(path)
      redirect?(diagnostics, path)
    else
      redirect?(diagnostics)
    end
  end

  def game(diagnostics, content)
    if diagnostics['Path:'] == '/start_game'
      start_game
    elsif diagnostics['Verb:'] == 'POST'
      @endpoint.play(content)
      '302 Found'
    else
      @endpoint = @current_game
    end
  end

  def start_game
    return '403 Forbidden' unless @current_game.nil?
    @current_game = Game.new
    @endpoint = @current_game
    '301 Moved Permanently'
  end

  def build_response(diagnostics)
    body = @endpoint.body(diagnostics)
    { headers: @endpoint.headers(body.length).join("\r\n"),
      body: body }
  end

  def redirect?(diagnostics, response_code = nil)
    if response_code.nil?
      build_response(diagnostics)
    else
      redirect_header = @endpoint.headers(0, response_code)
      redirect_header.insert(1, 'Location: http://127.0.0.1:9292/game')
      { headers: redirect_header.join("\r\n"), body: nil }
    end
  end
end
