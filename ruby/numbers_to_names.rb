response = nil

loop do
  print "Please enter the number of the month: "
  response = gets.chomp.to_i
  break if (1...12).include?(response)
  puts "Please enter a number between 1 and 12."
end

MONTHS = %w[January February March April May June July August September October November December]
puts "The name of the month is #{MONTHS[response - 1]}."
