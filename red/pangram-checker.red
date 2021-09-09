Red []

test-case1: "This is a test"
test-case2: "The quick brown fox jumps over the lazy dog."

pangram?: function [item] [
    not-letters: charset [not #"a" - #"z"]
    characters: unique extract/into lowercase item 1 []
    remove-each character characters [
        position: to integer! character
        not-letters/:character
    ]
    (length? characters) = 26
]

print pangram? test-case1
print pangram? test-case2