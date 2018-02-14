require './test/test_helper'
require './lib/paths/hello'

# Tests hello path
class HelloTest < Minitest::Test
  def diagnostics_input
    { 'Verb:' => 'GET', 'Path:' => '/',
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

  def test_body_content
    hello = Hello.new(1)
    expected = 'Hello, World! (1)'

    assert hello.body(diagnostics_input).include?(expected)
  end
end
