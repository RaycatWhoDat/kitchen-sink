REBOL [
    title: %all-functions.reb
    author: "Ray Perry"
]

lines: read/lines %../txr/docs/manpage.html
rules: [thru "<dt><a name=^"TOC-" thru "</a> <a href=^"" thru "^">" copy binding to </a></dt> to end]
foreach line lines [
    parse line rules
    unless not value? 'binding [
        print binding
        unset 'binding
    ]
]
