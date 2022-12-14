NUMBER_OF_VALID_NUMBERS = 20
numbers = []

until numbers.length == NUMBER_OF_VALID_NUMBERS do
  number = rand 999999
  numbers << number if number < 123199
end

numbers.each { |number| p number }
  
