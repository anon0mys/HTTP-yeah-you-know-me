require './test/test_helper'
require './lib/paths/word_search'

# Tests shutdown path
class WordSearchTest < Minitest::Test
  include TestHelper

  def test_it_loads_dictionary
    tester = WordSearch.new(1)

    assert tester.populate.include?('word')
    assert tester.populate.include?('zoo')
    refute tester.populate.include?('ijhsadgeoih')
  end

  def test_it_can_respond_with_test_outcome
    tester = WordSearch.new(1)
    expected_pass = 'word is a known word'
    expected_fail = 'ijhsadgeoih is not a known word'

    assert_equal expected_pass, tester.word?('word')
    assert_equal expected_fail, tester.word?('ijhsadgeoih')
  end

  def test_it_handles_multiple_words
    tester = WordSearch.new(1)
    expected = 'word is a known word<br>ijhsadgeoih is not a known word'
    given = { 'WORD:' => 'word', 'WORD2:' => 'ijhsadgeoih' }

    assert_equal expected, tester.words_test(given)
  end

  def test_body_content
    tester = WordSearch.new(1)
    expected = 'word is a known word<br>ijhsadgeoih is not a known word'

    assert tester.body(stub_diag_params('/word_search')).include?(expected)
  end
end
