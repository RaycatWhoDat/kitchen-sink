Red []

minimum-length: to-integer ask "What's the minimum length? "
number-of-special-chars: to-integer ask "How many special characters? "
number-of-numbers: to-integer ask "How many numbers? "

generate-password: function [
    minimum-length [integer!]
    number-of-special-chars [integer!]
    number-of-numbers [integer!]
    return: [string!]
] [
    if minimum-length < 1 [break]
    remaining-length: minimum-length - number-of-special-chars - number-of-numbers

    random/seed now/precise
    
    special-chars: take/part random "!@#$%^&*&" number-of-special-chars
    numbers: take/part random "0123456789" number-of-numbers
    letters: take/part random "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" remaining-length

    return random rejoin [special-chars numbers letters]
]

password: generate-password minimum-length number-of-special-chars number-of-numbers
print ["Your password is" newline password]
