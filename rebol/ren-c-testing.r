REBOL []

letters: charset [#"a" - #"z"]
capitals: charset [#"A" - #"Z"]
digits: charset [#"0" - #"9"]
alphanumeric: [letters | capitals | digits]

test-case: "This is a test"

matches: probe parse test-case [
    collect [
        some [keep alphanumeric opt space]
    ]
]