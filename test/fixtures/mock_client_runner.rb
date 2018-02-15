require './test/test_helper'
require './test/fixtures/mock_client'
require './lib/runner'

# Tests runner class
class ServerTest < Minitest::Test
  def diagnostics_expected
    '<html><head></head><body>'\
    '<pre><br>Verb: GET<br>Path: /<br>Protocol: HTTP/1.1<br>'\
    'Host: 127.0.0.1<br>Port: 9292<br>Origin: 127.0.0.1<br>'\
    'Accept: */*<br></pre></body></html>'
  end

  def test_server_responds_on_root_path
    client = MockClient.new
    client.root_request

    assert_equal diagnostics_expected, client.response.bodyra
  end
end
