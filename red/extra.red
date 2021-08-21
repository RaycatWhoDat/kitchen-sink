Red []

flatten: function [b [block!] /deep /local r value rule] [
    either deep [
        local: make block! length? b
        rule: [
            into [some rule]
        |   set value skip (append local value)
        ]
        parse b [some rule]
        local
    ] [
        r: make block! length? b
        head any [foreach v b [insert tail r v] r]
    ]
]

Z: make op! function [
    x [block!]
    y [block!]
] [
    collect [forall x [keep/only append to block! x/1 pick y index? x]]
]

~: make op! function [
    keys [block!]
    values [block!]
] [
    flatten keys Z values
]

..: make op! function [
    "Returns all natural numbers between and including START and END."
    start [integer! float!] "The first number in the range."
    end [integer! float!] "The last number in the range."
    return: [block!]
] [
	if start = end [return []]
	is-start-smaller: start < end
	total: either is-start-smaller [end - start + 1] [start - end + 1]
	collect [
		repeat index total [
			keep start + either is-start-smaller [index - 1] [-1 * (index - 1)]
		]
	]
]

R: function [
    "Returns all natural numbers between and including 1 and including END."
    end [number!] "The last number in the range."
    return: [block!]
] [
    either end > 1 [
        1 .. end
    ] [
        []
    ]
]

max-of-series: function [
    "Returns the largest in a series, assuming the first item's datatype! is the same as the rest of the items."
    series [block!]
    return: [block!]
] [
    type-assumption: type? series/1
    largest-item: none
    all-comparable-items: parse series [collect [some [keep type-assumption]]]
    foreach item all-comparable-items [
        if none? largest-item [largest-item: item]
        if item > largest-item [largest-item: item]
    ]
    largest-item
]

assert: function [
    "Throws an exception if a condition is false."
    :test [any-type!] "The conditional in question."
    message [string!] "The message to display when throwing the exception."
] [
    if not do :test [
        do make error! message
    ]
]