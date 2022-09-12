print "Enter text: "
text = gets.chomp

print "Enter word to redact: "
word = gets.chomp

puts text.gsub(word, "REDACTED")
