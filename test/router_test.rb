require_relative 'test_helper'
require './lib/router'
require 'pry'

# Tests router class
class RouterTest < Minitest::Test
  def diagnostics
    { 'Verb:' => 'GET', 'Path:' => '/hello',
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

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
    response = router.respond(diagnostics, 12)

    assert_equal expected, response.keys
    refute response[:headers].nil?
    refute response[:body].nil?
  end

  def test_router_returns_hello_body_and_assignes_correct_count
    router = Router.new
    hello_response = router.respond(diagnostics, 12)[:body]

    assert hello_response.include?('Hello, World! (1)')
  end

  def test_router_returns_different_class_body
    router = Router.new
    datetime_diag = diagnostics
    datetime_diag['Path:'] = '/datetime'
    datetime_response = router.respond(datetime_diag, 12)[:body]
    expected = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')

    assert datetime_response.include?(expected)
  end

  def test_router_tracks_hellos
    router = Router.new
    hello_1 = router.respond(diagnostics, 12)[:body]

    assert hello_1.include?('Hello, World! (1)')

    hello_2 = router.respond(diagnostics, 13)[:body]

    assert hello_2.include?('Hello, World! (2)')
  end
end
