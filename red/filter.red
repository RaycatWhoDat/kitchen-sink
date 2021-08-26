Red []

numbers: to-block ask "Enter a list of numbers, separated by spaces: "
even-numbers: remove-each number numbers [not even? number]
print ["The even numbers are:" (form even-numbers)]