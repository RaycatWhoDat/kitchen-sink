words = %w[a sTreSs mooNmen baGel doDeCaHeDron mUmble Consideration]
expected = %w[a t e b c u c]

words.zip(expected).each do |word, letter|
  fnl = word.downcase.chars.tally.reject { |letter, count| count > 1 }.first[0]
  raise Exception if fnl != letter
end

