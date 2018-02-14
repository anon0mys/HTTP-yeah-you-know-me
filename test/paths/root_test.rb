require './test/test_helper'
require './lib/paths/root'

# Tests response class
class ResponseTest < Minitest::Test
  def diagnostics_output
    '<pre><br>Verb: GET<br>Path: /<br>Protocol: HTTP/1.1<br>'\
    'Host: 127.0.0.1<br>Port: 9292<br>Origin: 127.0.0.1<br>'\
    'Accept: text/html,application/xhtml+xml,'\
    'application/xml;q=0.9,image/webp,*/*;q=0.8<br>'\
    '</pre>'
  end

  def diagnostics_input
    { 'Verb:' => 'GET', 'Path:' => '/',
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

  def test_diagnostics_content
    root = Root.new(1)
    output = root.print_diagnostics(diagnostics_input)

    assert_equal diagnostics_output, output
  end

  def test_headers_content
    root = Root.new(1)
    expected = ['http/1.1 200 ok',
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                'server: ruby',
                'content-type: text/html; charset=iso-8859-1',
                "content-length: 12\r\n\r\n"].join("\r\n")

    assert_equal expected, root.headers(12)
  end

  def test_body_content
    root = Root.new(1)
    expected = '<html><head></head><body>'\
               + diagnostics_output +
               '</body></html>'

    assert_equal expected, root.body(diagnostics_input)
  end
end
