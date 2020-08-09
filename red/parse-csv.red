Red []

#include %extra.red

csv-file: read/lines %MOCK_DATA.csv
foreach line at csv-file 2 [
    record: [first-name last-name email dob] ~ (split trim line ",")
    
    print ["First Name:" record/first-name]
    print ["Last Name:" record/last-name]
    print ["Email:" record/email]
    print ["Date of Birth:" record/dob]
    print ""
]

; Local Variables:
; mode: rebol
; compile-command: "./bin/red parse-csv.red"
; End:

