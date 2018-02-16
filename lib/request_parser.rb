require 'pry'

# Parses HTTP request into diagnostics hash
class RequestParser
  attr_reader :diagnostics

  def initialize
    @diagnostics = {}
  end

  def diagnostics_parser(request_lines)
    verb_line_parser(request_lines[0])
    request = format_request(request_lines)
    host_parser(request)
    the_rest_parser(request)
  end

  def format_request(request_lines)
    request_lines[1..-1].map do |line|
      line.split(': ') if line.include?(':')
    end.to_h
  end

  # Split into 3?
  def verb_line_parser(verb_line)
    keys = %w[Verb: Path: Protocol:]
    values = verb_line.split(' ')
    (0...keys.length).each do |index|
      @diagnostics[keys[index]] = values[index]
    end
    params_parser if @diagnostics['Path:'].include?('?')
  end

  def params_parser
    parameters = @diagnostics['Path:'].split('?')
    @diagnostics['Path:'] = parameters.shift
    param_string = parameters.shift
    @diagnostics['Params:'] = param_string.split('&').map do |param_pair|
      param_pair.split('=')
    end.to_h
  end

  def host_parser(request)
    host_line = request['Host'].split(':')
    @diagnostics['Host:'] = host_line[0]
    @diagnostics['Port:'] = host_line[1]
    @diagnostics['Origin:'] = host_line[0]
  end

  def the_rest_parser(request)
    if request.include?('Content-Length')
      @diagnostics['Content-Length:'] = request['Content-Length'].to_i
    end
    @diagnostics['Accept:'] = request['Accept']
  end
end
