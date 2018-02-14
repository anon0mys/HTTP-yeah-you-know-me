require './lib/paths/root'

# Response builder for /hello path
class Hello < Root
  def initialize(hello_requests)
    @hello_count = hello_requests
  end

  def body(diagnostics)
    output = print_diagnostics(diagnostics)
    hello = '<pre>' + "Hello, World! (#{@hello_count})" + '</pre>'
    "<html><head></head><body>#{hello}#{output}</body></html>"
  end
end
