
# Parses HTTP requests and creates response
class RequestParser
  def self.output(requests)
    response = '<pre>' + "Hello, World! (#{requests})" + '</pre>'
    "<html><head></head><body>#{response}</body></html>"
  end

  def self.headers(output_length)
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output_length}\r\n\r\n"].join("\r\n")
  end
end
