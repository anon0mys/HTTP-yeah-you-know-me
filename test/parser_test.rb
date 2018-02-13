require_relative 'test_helper'
require './lib/parser'

# Tests parser class
class RequestParserTest < Minitest::Test
  def test_headers_content
    expected = ['http/1.1 200 ok',
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                'server: ruby',
                'content-type: text/html; charset=iso-8859-1',
                "content-length: 12\r\n\r\n"].join("\r\n")

    assert_equal expected, RequestParser.headers(12)
  end

  def test_output_content
    expected = '<html><head></head><body><pre>'\
               'Hello, World! (1)'\
               '</pre></body></html>'

    assert_equal expected, RequestParser.output(1)
  end

  def test_diagnostics_content
    skip
    expected = '<pre> Verb: POST Path: / Protocol: HTTP/1.1'\
               'Host: 127.0.0.1 Port: 9292 Origin: 127.0.0.1'\
               'Accept: text/html,application/xhtml+xml,'\
               'application/xml;q=0.9,image/webp,*/*;q=0.8'\
               '</pre>'

    assert_equal expected, RequestParser.diagnostics
  end
end
