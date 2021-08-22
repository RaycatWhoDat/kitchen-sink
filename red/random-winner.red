Red []

names: []

forever [
    name: ask "Enter a name: "
    if empty? name [break]
    append names name
]

print rejoin ["The winner is " (first random names) "."]
