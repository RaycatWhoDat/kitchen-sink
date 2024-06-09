Red [needs: 'view]

win: layout [
    title "Window Test"
    size 300x100
    b: button "Click me" [
        view layout [
            below center
            text "I've been clicked!"
            button "Close" [unview]
        ]
    ]
]

center-face b
view win
