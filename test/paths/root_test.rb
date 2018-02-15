require './test/test_helper'
require './lib/paths/root'

# Tests response class
class RootTest < Minitest::Test
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

  def test_body_content
    root = Root.new(1)
    expected = '<html><head></head><body>'\
               + diagnostics_output +
               '</body></html>'

    assert_equal expected, root.body(diagnostics_input)
  end
end
