require './lib/paths/root'

# Response builder for /shutdown path
class Shutdown < Root
  def body(diagnostics)
    output = print_diagnostics(diagnostics)
    total = '<pre>' + "Total Requests (#{@requests})" + '</pre>'
    "<html><head></head><body>#{total}#{output}</body></html>"
  end
end
