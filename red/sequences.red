Red []

sequence: function [
    "Given a block of initial values and a step function, return a block of values generated from step-function."
    initial-values [block!] "The block of initial values."
    step-function [function!] "The function to generate the next value."
    /take iterations [integer!] "The number of times step-function should be invoked."
    /capped logic-block [block!] "A block that is valid in the ALL function. Use `value` to indicate the value generated from step-function."
    return: [block!]
] [
    if empty? initial-values [
        return []
    ]

    function-spec: spec-of :step-function
    remove-each spec-word function-spec [not word? spec-word]
    step-function-arity: length? function-spec

    if none? items [
        items: copy initial-values
    ]

    append-next-value: does [
        next-value: reduce reverse collect [
            repeat count step-function-arity [
                keep (pick reverse copy items count)
            ]
            keep :step-function
        ]
        append items next-value
    ]

    capped-append: does [
        until [
            append-next-value
            conditional: copy logic-block
            replace/all conditional 'value (last items)
            do all conditional
        ]
    ]

    limited-append: does [
        repeat count iterations [append-next-value]
    ]

    case [
        capped [capped-append]
        take [limited-append]
        true [append-next-value]
    ]
    
    items
]

fibonacci: function [item1 item2] [item1 + item2]
print sequence/capped [0 1] :fibonacci [value > 89]
print sequence/take [0 1] :fibonacci 7
print sequence [0 1] :fibonacci
