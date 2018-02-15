require './lib/response'

# Response builder for /shutdown path
class Shutdown < Response
  def body(diagnostics)
    total = '<pre>' + "Total Requests (#{@requests})" + '</pre>'
    body_builder(diagnostics, total)
  end
end
