print "Enter the first word: "
word1 = gets.chomp

print "Enter the second word: "
word2 = gets.chomp

is_anagram = word1.chars.sort == word2.chars.sort
puts "#{word1.upcase} and #{word2.upcase} are #{is_anagram ? '' : 'NOT '}anagrams."

