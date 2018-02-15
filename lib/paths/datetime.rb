require './lib/paths/root'

# Response builder for /datetime path
class DatePath < Root
  def body(diagnostics)
    date = "<pre>#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}</pre>"
    body_builder(diagnostics, date)
  end
end
