require './lib/paths/root'
require './lib/paths/hello'
require './lib/paths/datetime'
require './lib/paths/shutdown'
require './lib/paths/word_search'
require './lib/paths/game'

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
    body = @endpoint.body(diagnostics)
    { headers: @endpoint.headers(body.length),
      body: body }
  end

  def game(diagnostics, content)
    if diagnostics['Path:'] == '/start_game' && @current_game.nil?
      @current_game = Game.new
      @endpoint = @current_game
    else
      @endpoint = @current_game
      @endpoint.play(content) unless diagnostics['Verb:'] == 'GET'
    end
  end
end
