require './test/test_helper'
require './lib/paths/word_search'

# Tests shutdown path
class WordSearchTest < Minitest::Test
  def test_it_loads_dictionary

  end
  
  def test_it_can_test_words
    tester = WordSearch.new

    assert tester.word?('word')
    refute tester.word?('zzagater')
  end
end
