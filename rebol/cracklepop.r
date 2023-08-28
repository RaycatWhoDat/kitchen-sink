REBOL []

repeat index 100 [
    case/all [
        (modulo index 3) = 0 [prin "Crackle"]
        (modulo index 5) = 0 [prin "Pop"]
        not any [
            (modulo index 3) = 0
            (modulo index 5) = 0
        ] [prin index]
    ]
    prin newline
]