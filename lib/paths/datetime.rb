require './lib/paths/root'

# Response builder for /datetime path
class DatePath < Root
  def body(diagnostics)
    output = print_diagnostics(diagnostics)
    formatted_date = Time.now.strftime('%I:%M%p on %A, %B %e, %Y')
    date = '<pre>' + formatted_date + '</pre>'
    "<html><head></head><body>#{date}#{output}</body></html>"
  end
end
