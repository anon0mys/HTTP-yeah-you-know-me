require './lib/request_parser'
require 'pry'

# Parses Creates response for output to client
class Root
  def initialize(requests)
    @requests = requests
  end

  def body(diagnostics)
    output = print_diagnostics(diagnostics)
    "<html><head></head><body>#{output}</body></html>"
  end

  def headers(output_length)
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output_length}\r\n\r\n"].join("\r\n")
  end

  def print_diagnostics(diagnostics)
    content = diagnostics.map do |key, value|
      "#{key} #{value}"
    end
    '<pre><br>' + content.join('<br>') + '<br></pre>'
  end
end
