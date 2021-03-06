require_relative 'test_helper'
require './lib/router'
require 'pry'

# Tests router class
class RouterTest < Minitest::Test
  include TestHelper

  def test_router_creates_instance_of_root_class
    router = Router.new

    assert_instance_of Root, router.assign_endpoint('/', 1)
  end

  def test_router_creates_instance_of_path_class
    router = Router.new

    assert_instance_of Hello, router.assign_endpoint('/hello', 1)
  end

  def test_router_creates_different_classes
    router = Router.new

    assert_instance_of DatePath, router.assign_endpoint('/datetime', 1)
  end

  def test_router_returns_hash_of_headers_and_body
    router = Router.new
    expected = %i[headers body]
    response = router.respond(stub_diagnostics('/hello'), 12)

    assert_equal expected, response.keys
    refute response[:headers].nil?
    refute response[:body].nil?
  end

  def test_router_returns_hello_body_and_assignes_correct_count
    router = Router.new
    response = router.respond(stub_diagnostics('/hello'), 12)[:body]

    assert response.include?('Hello, World! (1)')
  end

  def test_router_returns_different_class_body
    router = Router.new
    response = router.respond(stub_diagnostics('/datetime'), 12)[:body]
    expected = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')

    assert response.include?(expected)
  end

  def test_router_tracks_hellos
    router = Router.new
    hello_one = router.respond(stub_diagnostics('/hello'), 12)[:body]

    assert hello_one.include?('Hello, World! (1)')

    hello_two = router.respond(stub_diagnostics('/hello'), 13)[:body]

    assert hello_two.include?('Hello, World! (2)')
  end

  def test_it_finds_path
    router = Router.new
    hello = stub_diagnostics('/hello')
    game = stub_post_diagnostics('/start_game')
    root = stub_diagnostics('/')
    router.find_path(game, 1, 'guess')

    assert_instance_of Hello, router.find_path(hello, 1, nil)
    assert_instance_of Game, router.current_game
    assert_instance_of Root, router.find_path(root, 1, nil)
  end

  def test_it_creates_game_and_sets_endpoint
    router = Router.new
    new_game_diag = stub_post_diagnostics('/start_game')
    router.game(new_game_diag, 'content')

    assert_instance_of Game, router.current_game
    assert_equal router.current_game, router.endpoint
  end

  def test_new_game_outputs_redirect
    router = Router.new
    diagnostics = stub_post_diagnostics('/start_game')
    expected = '301 Moved Permanently'
    response = router.respond(diagnostics, 1)

    assert response[:headers].include?(expected)
  end

  def test_game_get_request_outputs_body
    router = Router.new
    start = stub_post_diagnostics('/start_game')
    guess = stub_post_diagnostics('/game')
    request = stub_diagnostics('/game')
    router.game(start, '')
    router.game(guess, '1')
    expected = '<pre>You guessed too low! Guesses: [1]</pre>'

    assert router.respond(request, 4)[:body].include?(expected)
  end

  def test_it_redirects_on_game_post
    router = Router.new
    start = stub_post_diagnostics('/start_game')
    guess = stub_post_diagnostics('/game')
    router.game(start, '')
    expected = stub_302_redirect_headers
    response = router.respond(guess, 1, 1)

    assert_equal expected, response[:headers]
    assert_nil response[:body]
  end

  def test_build_response
    router = Router.new
    request = stub_diagnostics('/')
    router.find_path(request, 1, nil)
    response = router.build_response(request)
    body = stub_diag_printout('/')

    assert_equal stub_headers, response[:headers]
    assert response[:body].include?(body)
  end
end
