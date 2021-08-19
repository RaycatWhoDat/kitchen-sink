Red [needs: 'view]

view [
    title "Calculator"
    style b: button 60x60 bold font-size 18 [append f/text face/text]
    f: text 200x50 right white font-size 18 "" return
    below across b "7" b "8" b "9" b " / " 60x60 return
    across b "4" b "5" b "6" b " * " 60x60 return
    across b "1" b "2" b "3" b " - " 60x60 return
    across
    b "C" [clear f/text]
    b "0"
    b "=" [attempt [f/data: math load f/text]]
    b " + " 60x60 return
]
    