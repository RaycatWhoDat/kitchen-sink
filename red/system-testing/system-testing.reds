Red/System []

#import [
    "add2.so" cdecl [
        add2: "add2" [num1 [integer!] num2 [integer!] return: [integer!]]
    ]
]


memory: context [
    data: [0 0 0 0 0 0 0 0]
    integer-value: func [
        return: [integer!]
        /local data-size value index
    ]  [
        data-size: size? data
        value: 0
        index: 1
        loop data-size [
            value: value + (data/index << (8 - index))
            index: index + 1
        ]
        value
    ]
]

memory/data/8: 1
print [memory/integer-value lf]

add2 1 1
add2 2 2
print add2 5 7
;;print 2
;; print add2 1 1
