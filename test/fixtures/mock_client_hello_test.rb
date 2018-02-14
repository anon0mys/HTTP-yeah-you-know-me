require './test/test_helper'
require './test/fixtures/mock_client'
require './lib/runner'

# Tests runner class
class ServerTest < Minitest::Test
  def diagnostics_expected
    '<pre> Verb: GET Path: / Protocol: HTTP/1.1 '\
    'Host: 127.0.0.1 Port: 9292 Origin: 127.0.0.1 '\
    'Accept: text/html,application/xhtml+xml,'\
    'application/xml;q=0.9,image/webp,*/*;q=0.8 '\
    '</pre>'
  end
  
  def test_server_responds_hello_world
    client = MockClient.new
    client.get

    assert client.response.body.include?('Hello, World! (1)')

    client.get
    assert client.response.body.include?('Hello, World! (2)')
    assert client.response.body.include?(diagnostics_expected)
  end
end
