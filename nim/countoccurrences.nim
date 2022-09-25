import strutils

let testCases = @[
  @["the three truths", "th"],
  @["ababababab", "abab"]
]

proc countOccurrences(target: string, substring: string): int =
  target.split(substring).len - 1

for testCase in testCases:
  echo countOccurrences(testCase[0], testCase[1])
