def count_from starting_number = 0
  starting_number.times do |current_number|
    puts "#{starting_number + current_number}"
  end
end

count_from 20
