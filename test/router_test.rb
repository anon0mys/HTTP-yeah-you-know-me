require './test/test_helper'
require './lib/router'

# Tests parser class
class RouterTest < Minitest::Test
  def diagnostics_output
    '<pre><br>Verb: GET<br>Path: /<br>Protocol: HTTP/1.1<br>'\
    'Host: 127.0.0.1<br>Port: 9292<br>Origin: 127.0.0.1<br>'\
    'Accept: text/html,application/xhtml+xml,'\
    'application/xml;q=0.9,image/webp,*/*;q=0.8<br>'\
    '</pre>'
  end

  def test_headers_content
    expected = ['http/1.1 200 ok',
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                'server: ruby',
                'content-type: text/html; charset=iso-8859-1',
                "content-length: 12\r\n\r\n"].join("\r\n")

    assert_equal expected, Router.headers(12)
  end

  def test_body_content
    expected = '<html><head></head><body><pre>'\
               'Hello, World! (1)'\
               '</pre>' + diagnostics_output +
               '</body></html>'

    assert_equal expected, Router.body(1, diagnostics_output)
  end
end
