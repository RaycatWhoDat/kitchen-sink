Red []

operator-rule: ['+ | '- | '* | '/ ]
sub-expression-rule: [
    to operator-rule keep operator-rule
    to number! keep number!
]
expression-rule: [
    to number! keep number!
    sub-expression-rule
    opt some sub-expression-rule
]

formatted-input: transcode ask "> "
is-valid-expression: parse formatted-input [collect expression-rule]
if is-valid-expression [print do formatted-input]
