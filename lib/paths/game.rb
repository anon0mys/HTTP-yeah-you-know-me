require './lib/response'

class Game < Response
  attr_reader :response, :guesses
  attr_accessor :number

  def initialize
    @number = rand(100).to_i
    @response = '<pre>Good Luck!</pre>'
    @guesses = []
  end

  def body(diagnostics)
    body_builder(diagnostics, @response)
  end

  def play(guess)
    guess = guess.to_i
    @guesses.push(guess)
    correct if guess == @number
    incorrect(guess) if guess != @number
  end

  def correct
  end

  def incorrect()
  end
end
