require './lib/paths/root'

# Response builder for /shutdown path
class Shutdown < Root
  def body(diagnostics)
    total = '<pre>' + "Total Requests (#{@requests})" + '</pre>'
    body_builder(diagnostics, total)
  end
end
