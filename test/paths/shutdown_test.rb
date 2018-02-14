require './test/test_helper'
require './lib/paths/shutdown'

# Tests shutdown path
class ShutdownTest < Minitest::Test
  def diagnostics_input
    { 'Verb:' => 'GET', 'Path:' => '/',
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

  def test_body_content
    shutdown = Shutdown.new(12)
    expected = 'Total Requests (12)'

    assert shutdown.body(diagnostics_input).include?(expected)
  end
end
