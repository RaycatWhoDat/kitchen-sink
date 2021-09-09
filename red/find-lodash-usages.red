Red []

source-file: read %organization-members.service.ts

letters: charset [#"a" - #"z"]
capitals: charset [#"A" - #"Z"]
digits: charset [#"0" - #"9"]
alphanumeric: [letters | capitals | digits]
lodash-import-rule: ["import" space point-start: some alphanumeric point-end: space "from" space {'lodash/}]
lodash-usage-rule: ["_." point-start: some alphanumeric point-end: "("]
targets: [lodash-import-rule | lodash-usage-rule]

items: unique parse source-file [
    collect [
        some [
            to targets
            (length: (index? point-end) - (index? point-start))
            keep (take/part point-start length)
        ]
    ]
]

print either empty? items [
    "No lodash imports to merge."
] [
    rejoin [
        "import ^{ "
        collect [
            forall items [
                keep rejoin [
                    items/1
                    either last? items [] [", "]
                ]
            ]
        ]
        " ^} from 'lodash';"
    ]
]