require './test/test_helper'
require './lib/paths/shutdown'

# Tests shutdown path
class ShutdownTest < Minitest::Test
  include TestHelper

  def test_body_content
    shutdown = Shutdown.new(12)
    expected = 'Total Requests (12)'

    assert shutdown.body(stub_diagnostics('/')).include?(expected)
  end
end
