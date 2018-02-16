require './lib/request_parser'

# Parent class for building path responses
class Response
  def initialize(requests)
    @requests = requests
  end

  def body_builder(diagnostics, output = nil)
    footer = print_diagnostics(diagnostics)
    "<html><head></head><body>#{output}#{footer}</body></html>"
  end

  def headers(output_length, response_code = '200 ok')
    ["http/1.1 #{response_code}",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output_length}\r\n\r\n"]
  end

  def print_diagnostics(diagnostics)
    content = diagnostics.map do |key, value|
      "#{key} #{value}"
    end
    '<pre><br>' + content.join('<br>') + '<br></pre>'
  end
end
