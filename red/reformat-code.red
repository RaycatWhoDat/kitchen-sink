This will output itself with all `kebab-case` words changed to `camelCase`.

Red []

letters: charset [#"a" - #"z"]
capitals: charset [#"A" - #"Z"]
digits: charset [#"0" - #"9"]
no-capitals: [letters | digits]
alphanumeric: [letters | capitals | digits]
kebab-case-separator: "-"
snake-case-separator: "_"
kebab-case-rule: [some alphanumeric some ["-" some alphanumeric]]
snake-case-rule: [some alphanumeric some ["_" some alphanumeric]]
camel-case-rule: [some no-capitals some [capitals some no-capitals]]

kebab-case-to-camel-case: function [item] [
    parse item [
        some [
            to kebab-case-separator
            point:
            (if all [point/2 <> space point/2 <> dbl-quote]
                [remove point uppercase/part point 1])
        ]
    ]
]

test-case: read %reformat-code.red
parse test-case [
    some [
        to kebab-case-rule
        item:
        (kebab-case-to-camel-case item)
    ]
]

print test-case