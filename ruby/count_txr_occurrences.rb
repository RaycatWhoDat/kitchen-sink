puts "Counting the number of 'TXR' occurrences..."
puts File.readlines("../awk/test-text.txt").inject(0) { |count, line| count += line.scan(/TXR/).length }
