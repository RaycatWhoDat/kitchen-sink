Red/System []

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
print memory/integer-value
