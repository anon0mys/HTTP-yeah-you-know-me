require './test/test_helper'
require './lib/paths/datetime'

# Tests hello path
class DatePathTest < Minitest::Test
  include TestHelper

  def test_body_content
    date = DatePath.new(12)
    expected = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')

    assert date.body(stub_diagnostics('/datetime')).include?(expected)
  end
end
