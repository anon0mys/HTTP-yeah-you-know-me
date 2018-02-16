require './test/test_helper'
require './lib/paths/hello'

# Tests hello path
class HelloTest < Minitest::Test
  include TestHelper

  def test_body_content
    hello = Hello.new(1)
    expected = 'Hello, World! (1)'

    assert hello.body(stub_diagnostics('/hello')).include?(expected)
  end
end
