Red []

count-numbers: function [end] [
    numbers: collect [repeat index end [keep index]]
    remove-each item numbers [not none? find (to string! item) "1"]
    print ["There are" (length? numbers) "numbers between 1 and" end "that don't contain the digit ^"1^"."]
    print ["The numbers are:" numbers]
]

count-numbers 15
count-numbers 25