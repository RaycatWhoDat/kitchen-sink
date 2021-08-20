Red []

count-occurrences: function [string substring] [
    length? parse string [collect [some [keep substring to substring]]]
]

test-case1: "the three truths"
test-case2: "ababababab"

print [test-case1 "-" count-occurrences test-case1 "th"]
print [test-case2 "-" count-occurrences test-case2 "abab"]