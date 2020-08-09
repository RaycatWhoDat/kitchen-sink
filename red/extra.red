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
