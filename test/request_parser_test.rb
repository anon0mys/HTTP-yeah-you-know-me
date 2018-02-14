require './test/test_helper'
require './lib/request_parser'

# Tests parser class
class RequestParserTest < Minitest::Test
  def setup
    @parser = RequestParser.new
  end

  def request_lines
    ['GET / HTTP/1.1',
     'Host: 127.0.0.1:9292',
     'Accept: text/html,application/xhtml+xml,'\
     'application/xml;q=0.9,image/webp,*/*;q=0.8',
     'User-Agent: Faraday v0.14.0',
     'Accept-Language: en-US,en;q=0.8']
  end

  def test_format_request
    expected = { 'Host' => '127.0.0.1:9292',
                 'Accept' => 'text/html,application/xhtml+xml,'\
                 'application/xml;q=0.9,image/webp,*/*;q=0.8',
                 'User-Agent' => 'Faraday v0.14.0',
                 'Accept-Language' => 'en-US,en;q=0.8' }

    assert_equal expected, @parser.format_request(request_lines)
  end

  def test_build_diagnostics_hash
    expected = { 'Verb:' => 'GET', 'Path:' => '/',
                 'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
                 'Port:' => '9292', 'Origin:' => '127.0.0.1',
                 'Accept:' => 'text/html,application/xhtml+xml,'\
                 'application/xml;q=0.9,image/webp,*/*;q=0.8' }
    @parser.diagnostics_parser(request_lines)

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

  def test_host_parser
    given = { 'Host' => '127.0.0.1:9292' }
    expected = { 'Host:' => '127.0.0.1',
                 'Port:' => '9292',
                 'Origin:' => '127.0.0.1' }
    @parser.host_parser(given)

    assert_equal expected, @parser.diagnostics
  end
end
