REBOL [
    title: %all-functions.reb
    author: "Ray Perry"
]

lines: read/lines %../txr/docs/manpage.html
rules: [
    thru "class=^"tocanchor^">"
    copy listing: to "</a> <a href=^""
    thru "^">"
    copy entry: to </a></dt>
    to end
]
foreach line lines [
    parse line rules
    if all [
        value? 'listing
        value? 'entry
    ] [
        print rejoin [listing " - " entry]
        unset 'listing
        unset 'entry
    ]
]
