test_cases = [["the three truths", "th"], ["ababababab", "abab"]]

def count_occurrences(string, substring)
  string.split(substring).size - 1
end

test_cases.each do |test_case|
  p count_occurrences(test_case[0], test_case[1])
end
