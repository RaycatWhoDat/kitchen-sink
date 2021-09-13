REBOL []

letters: charset [#"a" - #"z"]
capitals: charset [#"A" - #"Z"]
digits: charset [#"0" - #"9"]
symbols: charset [#"^"" #" " #"@" #"." #"/"]
alphanumeric: [letters | capitals | digits]
field-rule: [some [alphanumeric | symbols]]

csv-file-port: open/read %data/MOCK_DATA.csv
csv-file: read/lines csv-file-port

for-each line at csv-file 2 [
    [first-name last-name email dob]: unpack parse line [
        collect [
            some [keep field-rule thru ["," | end]]
        ]
    ]

    print [
        "First Name:" first-name lf
        "Last Name:" last-name lf
        "Email:" email lf
        "DOB:" dob lf
    ]
]

