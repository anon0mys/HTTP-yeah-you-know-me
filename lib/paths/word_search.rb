require './lib/response'

# Determines if a parameter is a word
class WordSearch < Response
  def word?(parameter)
    if populate.include?(parameter)
      "#{parameter} is a known word"
    else
      "#{parameter} is not a known word"
    end
  end

  def populate
    File.readlines('/usr/share/dict/words').map(&:strip)
  end

  def words_test(parameters)
    parameters.values.map do |paramter|
      word?(paramter)
    end.join('<br>')
  end

  def body(diagnostics)
    parameters = diagnostics['Params:']
    output = '<pre>' + words_test(parameters) + '</pre>'
    body_builder(diagnostics, output)
  end
end
