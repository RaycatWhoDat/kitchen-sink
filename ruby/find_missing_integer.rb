input = [5, 2, 9, 13, 0]

missing_integer = input.reject { |item| item <= 0 }.sort.inject(1) do |smallest_integer, number|
  number == smallest_integer ? smallest_integer + 1 : smallest_integer
end

p missing_integer
