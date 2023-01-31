require "set"

test_cases = %w[lumberjacks background downstream six-year-old isograms];

def isogram?(str)
  characters = str.chars.delete_if { |char| char.match(/\-|\ /) }
  characters.size == Set.new(characters).size
end

p test_cases.map { |test_case| isogram?(test_case) }
