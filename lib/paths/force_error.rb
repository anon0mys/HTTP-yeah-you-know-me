require './lib/response'

# Response builder for /force_error path
class ForceError < Response
  def body(diagnostics)
    begin
      raise ArgumentError
    rescue ArgumentError => exception
      error = '<pre>500 Internal Server Error</pre>'
      error += exception.backtrace.join("\n")
      body_builder(diagnostics, error)
    end
  end

  def headers(output_length, response_code = '500 Internal Server Error')
    ["http/1.1 #{response_code}",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output_length}\r\n\r\n"]
  end
end
