require_relative 'test_helper'
require './lib/router'
require 'pry'

# Tests router class
class RouterTest < Minitest::Test
  include TestHelper

  def test_router_creates_instance_of_root_class
    router = Router.new

    assert_instance_of Root, router.assign_endpoint('/', 1)
  end

  def test_router_creates_instance_of_path_class
    router = Router.new

    assert_instance_of Hello, router.assign_endpoint('/hello', 1)
  end

  def test_router_creates_different_classes
    router = Router.new

    assert_instance_of DatePath, router.assign_endpoint('/datetime', 1)
  end

  def test_router_returns_hash_of_headers_and_body
    router = Router.new
    expected = %i[headers body]
    response = router.respond(stub_diagnostics('/hello'), 12)

    assert_equal expected, response.keys
    refute response[:headers].nil?
    refute response[:body].nil?
  end

  def test_router_returns_hello_body_and_assignes_correct_count
    router = Router.new
    response = router.respond(stub_diagnostics('/hello'), 12)[:body]

    assert response.include?('Hello, World! (1)')
  end

  def test_router_returns_different_class_body
    router = Router.new
    response = router.respond(stub_diagnostics('/datetime'), 12)[:body]
    expected = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')

    assert response.include?(expected)
  end

  def test_router_tracks_hellos
    router = Router.new
    hello_one = router.respond(stub_diagnostics('/hello'), 12)[:body]

    assert hello_one.include?('Hello, World! (1)')

    hello_two = router.respond(stub_diagnostics('/hello'), 13)[:body]

    assert hello_two.include?('Hello, World! (2)')
  end
end
