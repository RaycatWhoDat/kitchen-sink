Red []

state: make reactor! [
    number1: 0
    number2: 1
    sum: is [ number1 + number2 ]
    difference: is [ number1 - number2 ]
    product: is [ number1 * number2 ]
    quotient: is [ number1 / number2 ]
]

operations: [sum difference product quotient]

forever [
    state/number1: to-integer ask "What is the first number? "
    state/number2: to-integer ask "What is the second number? "
    forall operations [
        print ["The" operations/1 "is:" select state operations/1]
    ]
    operations: back operations
]