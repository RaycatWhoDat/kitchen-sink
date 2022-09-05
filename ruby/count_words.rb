words = "
The foo the foo the
defenestration the
"

words.strip.downcase.split(" ").tally.each { |word, count| puts "#{word}: #{count}" }

