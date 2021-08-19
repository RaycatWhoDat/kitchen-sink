Red [
    title: "GUI Calculator"
    needs: 'view
]

stack: []
last-calculation: 0
calculate: does [
    if integer? last stack [
        last-calculation: math stack
    ]
    ?? last-calculation
]

calculate-button: [button "=" [calculate]]
operator-button: func [label] [
    ?? label
    compose/deep [
        button (to-string label) [
            if empty? stack [return none]
            ?? stack
            new-number: to-integer rejoin stack
            ?? new-number
            stack: [new-number (label)]
            ?? stack
        ]
    ]
]
number-button: func [label] [
    compose/deep [
        button (to-string label) [
            append stack (label)
        ]
    ]
]

button-switcher: function [label] [
    if label = '= [return calculate-button]
    if find ['+ '- '* '/] label [return operator-button label]
    number-button label
]

display: compose [text (form last-calculation)]
button-row: function [labels] [
    buttons: make block! 3
    foreach label labels [
        append buttons do [button-switcher label]
    ]
    buttons
]

window: compose [
    title "Calculator"
    below (display)
    across (button-row [7 8 9 '/]) return
    across (button-row [4 5 6 '*]) return
    across (button-row [1 2 3 '-]) return
    across (button-row ['C 0 '= '+]) return
]

view window

