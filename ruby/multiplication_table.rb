numbers = (0...13).to_a
printf("%3s " * 14 + "\n", "", *numbers)
numbers.product(numbers).each_with_index do |pair, index|
  printf("%3s ", pair[0]) if index % 13 == 0
  printf(%Q[%3s #{"\n" if (index + 1) % 13 == 0}], pair.inject(:*))
end
