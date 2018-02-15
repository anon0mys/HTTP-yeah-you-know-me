require './test/test_helper'
require './lib/paths/datetime'

# Tests hello path
class DatePathTest < Minitest::Test
  def diagnostics_input
    { 'Verb:' => 'GET', 'Path:' => '/',
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

  def footer
    '<pre><br>Verb: GET<br>Path: /<br>Protocol: HTTP/1.1<br>'\
    'Host: 127.0.0.1<br>Port: 9292<br>Origin: 127.0.0.1<br>'\
    'Accept: text/html,application/xhtml+xml,'\
    'application/xml;q=0.9,image/webp,*/*;q=0.8<br>'\
    '</pre>'
  end

  def test_body_content
    date = DatePath.new(12)
    expected = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')
    other_expected = "<html><head></head><body><pre>#{expected}</pre>"\
                     "#{footer}</body></html>"

    assert date.body(diagnostics_input).include?(expected)
    assert_equal other_expected, date.body(diagnostics_input)
  end
end
