def encode(number)
  number.to_s.split("").map { |digit|  "-----.....----"[digit.to_i .. digit.to_i + 4] }.join
end

def decode(code)
  result = []
  (0 ... code.length).step(5) { |index|
    result.push("-----.....----".index(code[index, 5]))
  }
  result.join.to_i
end

puts encode 1203
puts decode "-----.....-----.....-----"
