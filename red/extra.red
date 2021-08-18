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
][
    collect [forall x [keep/only append to block! x/1 pick y index? x]]
]

~: make op! function [
    keys [block!]
    values [block!]
][
    flatten keys Z values
]

..: make op! function [
    start [number!]
    end [number!]
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

R: function [end [number!]] [
    unless end > 1 [return []]
    1 .. end
]