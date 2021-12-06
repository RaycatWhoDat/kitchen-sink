Red []

cells: none
cells-limit: 5000
cell-pointer: 1

increment-char: #"+"
increment-action: does [poke cells cell-pointer (cells/:cell-pointer + 1)]

decrement-char: #"-"
decrement-action: does [poke cells cell-pointer (cells/:cell-pointer - 1)]

next-cell-char: #">"
next-cell-action: does [
    if cell-pointer <= cells-limit [cell-pointer: cell-pointer + 1]
    if none? probe cells/:cell-pointer [append cells 0]
]

previous-cell-char: #"<"
previous-cell-action: does [
    if cell-pointer > 1 [cell-pointer: cell-pointer - 1]
]

print-ascii-value-char: #"."
print-ascii-value-action: does [print to-char cells/:cell-pointer]

read-char-to-cell-char: #","
read-char-to-cell-action: does [
    result: input
    alter at cells cell-pointer result/1
]

loop-start-char: #"["
loop-start-action: does []

loop-end-char: #"]"
loop-end-action: does []

all-operators: [
    increment-char (increment-action)
    | decrement-char (decrement-action)
    | next-cell-char (next-cell-action)
    | previous-cell-char (previous-cell-action)
    | print-ascii-value-char (print-ascii-value-action)
    | read-char-to-cell-char (read-char-to-cell-action)
    | loop-start-char (loop-start-action)
    | loop-end-char (loop-end-action)
]

all-characters: charset reduce [
    increment-char
    decrement-char
    next-cell-char
    previous-cell-char
    print-ascii-value-char
    read-char-to-cell-char
    loop-start-char
    loop-end-char
]

ignored-characters: complement all-characters

program-rules: [some [all-operators]]

test-case1: "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++." ; 65
; TODO: Fix.
test-case2: "++++++ [ > ++++++++++ < - ] > +++++ ." ; 65

parse-bf: function [program] [
    remove-each character program [
        index: to-integer character
        ignored-characters/:character
    ]
    parse program program-rules
    ?? cells
]

cells: make vector! [0]
parse-bf test-case1

cells: make vector! [0]
parse-bf test-case2

