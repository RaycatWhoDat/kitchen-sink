Red [needs: 'view]

list-of-functions: [
    "Encode JSON string"
    "Decode JSON string"
    "Convert ASCII to Base64"
    "Convert Base64 to ASCII"
]

set-color: function [] [
    function-stage/color: first at list-of-colors functions-list/selected
]

view [
    title "This is a test"
    across
    functions-list: text-list 300x500 data list-of-functions on-select [set-color] select 1
    function-stage: base 500x500 transparent
    do [
        list-of-colors: reduce [red blue orange green]
        set-color
    ]
]