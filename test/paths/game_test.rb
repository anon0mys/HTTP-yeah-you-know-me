require './test/test_helper'
require './lib/paths/game'

# Tests game class
class GameTest < Minitest::Test
  include TestHelper

  def test_it_initializes_with_random_number
    game = Game.new
    numbers = (0..100).to_a

    assert numbers.include?(game.number)
  end

  def test_body_output_at_start
    game = Game.new
    expected = '<pre>Good Luck!</pre>'
    response = game.body(stub_post_diagnostics('/start_game'))

    assert response.include?(expected)
  end

  def test_it_can_compare_numbers
    game = Game.new
    game.number = 10
    game.play(stub_post_diagnostics('/game'), '1')
    game.play(stub_post_diagnostics('/game'), '2')
    expected = '<pre>You guessed too low! Guesses: [1,2]</pre>'
    game.compare_guess

    assert_equal expected, game.response
  end

  def test_post_a_guess
    game = Game.new
    game.play(stub_post_diagnostics('/game'), '14')

    assert_equal [14], game.guesses
  end
end
