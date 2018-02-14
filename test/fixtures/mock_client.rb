require 'faraday'

# Imitates client requests
class MockClient
  attr_reader :connection, :response

  def initialize
    @connection = Faraday.new('http://127.0.0.1:9292')
    @response = nil
  end

  def root_request
    @response = @connection.get
  end

  def shutdown_request
    @response = @connection.get '/shutdown'
  end

  def hello_request
    @response = @connection.get '/hello'
  end

  def datetime_request
    @response = @connection.get '/datetime'
  end
end
