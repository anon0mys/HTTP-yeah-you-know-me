require './test/test_helper'
require './lib/paths/root'

# Tests response class
class RootTest < Minitest::Test
  include TestHelper

  def test_body_content
    root = Root.new(1)
    expected = '<html><head></head><body>'\
               + stub_diag_printout('/') +
               '</body></html>'

    assert_equal expected, root.body(stub_diagnostics('/'))
  end
end
