require './test/test_helper'
require './lib/paths/force_error'

# Tests shutdown path
class ForceErrorTest < Minitest::Test
  include TestHelper

  def test_it_outputs_error_code
    error = ForceError.new(1)
    body = error.body(stub_diagnostics('/force_error'))

    assert body.include?('500 Internal Server Error')
  end

  def test_headers_contains_error_code
    error = ForceError.new(1)
    headers = error.headers(1)

    assert headers[0].include?('500 Internal Server Error')
  end
end
