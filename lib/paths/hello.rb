require './lib/response'

# Response builder for /hello path
class Hello < Response
  def initialize(hello_requests)
    @hello_count = hello_requests
  end

  def body(diagnostics)
    hello = '<pre>' + "Hello, World! (#{@hello_count})" + '</pre>'
    body_builder(diagnostics, hello)
  end
end
