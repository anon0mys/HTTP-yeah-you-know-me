require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

# Mixins for request and diagnostics inputs and expected values
module TestHelper
  def stub_post_lines(path)
    ["POST #{path} HTTP/1.1",
     'User-Agent: Faraday v0.14.0',
     'Content-Length: 0',
     'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'Accept: */*',
     'Connection: close',
     'Host: 127.0.0.1:9292',
     'Content-Type: application/x-www-form-urlencoded']
  end

  def stub_post_diagnostics(path)
    { 'Verb:' => 'POST', 'Path:' => path,
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Content-Length:' => 0,
      'Accept:' => '*/*' }
  end

  def stub_get_lines(path)
    ["GET #{path} HTTP/1.1",
     'Host: 127.0.0.1:9292',
     'Connection: keep-alive',
     'Cache-Control: no-cache',
     'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) '\
     'AppleWebKit/537.36 (KHTML, like Gecko) '\
     'Chrome/64.0.3282.167 Safari/537.36',
     'Postman-Token: 93c2f193-edcd-c8ac-b8f1-e778ce8484c1',
     'Accept: text/html,application/xhtml+xml,'\
     'application/xml;q=0.9,image/webp,*/*;q=0.8',
     'Accept-Encoding: gzip, deflate, br',
     'Accept-Language: en-US,en;q=0.9,ro;q=0.8']
  end

  def stub_get_hash
    { 'Host' => '127.0.0.1:9292',
      'Connection' => 'keep-alive',
      'Cache-Control' => 'no-cache',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) '\
      'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 '\
      'Safari/537.36',
      'Postman-Token' => '93c2f193-edcd-c8ac-b8f1-e778ce8484c1',
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,'\
      'image/webp,*/*;q=0.8',
      'Accept-Encoding' => 'gzip, deflate, br',
      'Accept-Language' => 'en-US,en;q=0.9,ro;q=0.8' }
  end

  def stub_diagnostics(path)
    { 'Verb:' => 'GET', 'Path:' => path,
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8' }
  end

  def stub_diag_params(path)
    { 'Verb:' => 'GET', 'Path:' => path,
      'Protocol:' => 'HTTP/1.1', 'Host:' => '127.0.0.1',
      'Port:' => '9292', 'Origin:' => '127.0.0.1',
      'Accept:' => 'text/html,application/xhtml+xml,'\
      'application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Params:' => { 'WORD:' => 'word',
                     'WORD2:' => 'ijhsadgeoih' } }
  end

  def stub_diag_printout(path)
    "<pre><br>Verb: GET<br>Path: #{path}<br>Protocol: HTTP/1.1<br>"\
    'Host: 127.0.0.1<br>Port: 9292<br>Origin: 127.0.0.1<br>'\
    'Accept: text/html,application/xhtml+xml,'\
    'application/xml;q=0.9,image/webp,*/*;q=0.8<br>'\
    '</pre>'
  end

  def stub_headers
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: 240\r\n\r\n"].join("\r\n")
  end

  def stub_302_redirect_headers
    ['http/1.1 302 Found',
     'Location: http://127.0.0.1:9292/game',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: 0\r\n\r\n"].join("\r\n")
  end
end
