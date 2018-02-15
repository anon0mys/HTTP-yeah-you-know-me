require './lib/paths/root'

class WordSearch
  def word?

  end

  def populate
    File.readlines('/usr/share/dict/words').map(&:strip)
  end
end
