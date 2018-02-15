require './lib/response'

# Response for root path
class Root < Response
  def body(diagnostics)
    body_builder(diagnostics)
  end
end
