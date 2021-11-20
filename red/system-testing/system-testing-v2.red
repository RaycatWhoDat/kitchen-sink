Red []

red-add2: function [
    number1 [integer!]
    number2 [integer!]
    return: [integer!]
] [
    number1 + number2
]

reds-add2: routine [
    number1 [integer!]
    number2 [integer!]
    return: [integer!]
] [
    number1 + number2
]

print red-add2 12 34
print reds-add2 56 78
