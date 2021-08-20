Red []

numbers: to-block ask "Enter a list of numbers, separated by spaces: "
even-numbers: collect [foreach number numbers [if even? number [keep number]]]
print ["The even numbers are:" (form even-numbers)]