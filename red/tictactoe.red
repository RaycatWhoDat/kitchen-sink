Red []

naught-or-cross: [O X]

make-square: function [initial-value][
    make object! [value: initial-value]
]

board: collect [repeat counter 9 [keep make-square naught-or-cross/1]]

display-board: function [board][
    print [board/1 "|" board/2 "|" board/3]
    print "--+---+--"
    print [board/4 "|" board/5 "|" board/6]
    print "--+---+--"
    print [board/7 "|" board/8 "|" board/9]
]

display-board collect [foreach square board [keep square/value]]