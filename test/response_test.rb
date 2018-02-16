require './test/test_helper'
require './lib/response'

# Tests response super-class
class ResponseTest < Minitest::Test
  include TestHelper

  def test_diagnostics_content
    root = Response.new(1)
    output = root.print_diagnostics(stub_diagnostics('/'))

    assert_equal stub_diag_printout('/'), output
  end

  def test_headers_content
    root = Response.new(1)
    expected = stub_headers

    assert_equal expected, root.headers(12)
  end
end
