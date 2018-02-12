require 'faraday'

# Imitates client requests
class MockClient
  attr_reader :connection, :response

  def initialize
    @connection = Faraday.new(url: 'http://127.0.0.1:9292')
    @response = nil
  end

  def get
    @response = @connection.get
  end
end
