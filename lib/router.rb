require './lib/request_parser'
require 'pry'

# Parses HTTP requests and creates response
class Router
  def self.body(request_count, diagnostics)
    hello = '<pre>' + "Hello, World! (#{request_count})" + '</pre>'
    "<html><head></head><body>#{hello}#{diagnostics}</body></html>"
  end

  def self.headers(output_length)
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output_length}\r\n\r\n"].join("\r\n")
  end
end
