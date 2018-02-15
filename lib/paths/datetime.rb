require './lib/response'

# Response builder for /datetime path
class DatePath < Response
  def body(diagnostics)
    date = "<pre>#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}</pre>"
    body_builder(diagnostics, date)
  end
end
