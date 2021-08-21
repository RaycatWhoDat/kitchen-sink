Red []

#include %extra.red

csv-file: read/lines %../d/MOCK_DATA.csv

delimiter: rejoin [dbl-quote comma]
quoted-field: compose [skip keep to delimiter (length? delimiter) skip]
unquoted-field: [keep to comma skip]
field: [ahead dbl-quote quoted-field | unquoted-field]
last-field: [keep to end]

parse-csv-line: function [line [string!]][
    parse line [collect [some field last-field]]
]

headers: parse-csv-line csv-file/1

foreach line at csv-file 2 [
    fields: parse-csv-line line

    repeat index (length? headers) [
        print rejoin [(pick headers index) ": " (pick fields index)]
    ]
    
    print space
]

; Local Variables:
; mode: rebol
; compile-command: "./bin/red parse-csv.red"
; End:

