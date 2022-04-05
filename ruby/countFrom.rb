def countFrom(startingNumber = 0)
  startingNumber.times do |currentNumber|
    puts "#{startingNumber + currentNumber}"
  end
end

countFrom(10)
