require './test/test_helper'
require './lib/request_parser'

# Tests parser class
class RequestParserTest < Minitest::Test
  include TestHelper

  def setup
    @parser = RequestParser.new
  end

  def test_format_request
    expected = stub_get_hash

    assert_equal expected, @parser.format_request(stub_get_lines('/'))
  end

  def test_build_diagnostics_hash
    expected = stub_diagnostics('/')
    @parser.diagnostics_parser(stub_get_lines('/'))

    assert_equal expected, @parser.diagnostics
  end

  def test_verb_line_parser
    given = 'GET / HTTP/1.1'
    expected = { 'Verb:' => 'GET',
                 'Path:' => '/',
                 'Protocol:' => 'HTTP/1.1' }
    @parser.verb_line_parser(given)

    assert_equal expected, @parser.diagnostics
  end

  def test_verb_line_parser_handles_parameters
    given = 'GET /word_search?param=value&param2=value2 HTTP/1.1'
    expected = { 'Verb:' => 'GET',
                 'Path:' => '/word_search',
                 'Protocol:' => 'HTTP/1.1',
                 'Params:' => { 'param' => 'value',
                                'param2' => 'value2' } }
    @parser.verb_line_parser(given)

    assert_equal expected, @parser.diagnostics
  end

  def test_host_parser
    given = { 'Host' => '127.0.0.1:9292' }
    expected = { 'Host:' => '127.0.0.1',
                 'Port:' => '9292',
                 'Origin:' => '127.0.0.1' }
    @parser.host_parser(given)

    assert_equal expected, @parser.diagnostics
  end

  def test_the_rest_parser
    given = { 'Content-Length' => '0',
              'Accept' => '*/*' }
    expected = { 'Content-Length:' => 0,
                 'Accept:' => '*/*' }
    @parser.the_rest_parser(given)

    assert_equal expected, @parser.diagnostics
  end

  def test_parse_post_request
    expected = stub_post_diagnostics('/start_game')
    @parser.diagnostics_parser(stub_post_lines('/start_game'))

    assert_equal expected, @parser.diagnostics
  end
end
