Red []

do read https://raw.githubusercontent.com/RayMPerry/crimson/master/crimson.red

csv-file: read/lines %../d/MOCK_DATA.csv

quoted-field: [ahead dbl-quote skip keep to dbl-quote skip]
unquoted-field: [keep to comma skip]
field: [quoted-field | unquoted-field]
last-field: [keep to end]

parse-csv-line: function [line] [
    parse line [collect [some field last-field]]
]

headers: parse-csv-line csv-file/1

foreach line at csv-file 2 [
    fields: parse-csv-line line
    
    forall headers [
        print rejoin [headers/1 ": " (pick fields index? headers)]
    ]
    
    print space
]

; Local Variables:
; mode: rebol
; compile-command: "./bin/red parse-csv.red"
; End:

