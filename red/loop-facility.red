Red []

;; Word groups
group2: ['for | 'as]
group3: ['upfrom | 'from]
group4: ['upto | 'to | 'below]
group5: ['in | 'on]
group6: ['downto | 'to | 'above]
group7: ['the | 'each]
group8: ['key | 'keys | 'value | 'values]
group9: ['of | 'in]
group10: ['if | 'when | 'unless]
group11: ['collect | 'collecting | 'append | 'appending]
group12: ['count | 'counting | 'sum | 'summing | 'maximize | 'maximizing | 'minimize | 'minimizing]
group13: ['initially | 'finally]
group14: ['while | 'until | 'always | 'never | 'thereis]

;; Rules
named-rule: ['named string!]
by-step-rule: ['by integer!]
by-function-rule: ['by [word! | function!]]
condition-rule: ['and block!]
additional-predicate-rule: [opt some condition-rule]
topic-rule: [block! | 'it]
vector-rule: ['across any-type!]
upward-sequence-rule: [opt [group3 integer!] opt [group4 any-type!]]
ambiguous-sequence-rule: ['from integer! ['downto | 'above] any-type!]
downward-sequence-rule: ['downfrom integer! opt [group6 any-type!]]
sequence-rules: [[ambiguous-sequence-rule | upward-sequence-rule | downward-sequence-rule] opt by-step-rule]
series-rule: [group5 block! opt by-function-rule]
assignment-rule: ['= any-type! opt ['then any-type!]]
being-rule: [group7 group8 group9 block!]
with-rule: ['with word! '= any-type! opt ['and word! '= any-type!]]
for-as-rule: [group2 word! [sequence-rules | series-rule | assignment-rule | vector-rule | being-rule]]

doing-rule: [['do | 'doing] block!]
predicate-rule: [group10 block! additional-predicate-rule opt ['else block! additional-predicate-rule]]
return-rule: ['return topic-rule]
aggregation-rule: [group11 topic-rule opt ['into word!]]
counting-rule: [group12 topic-rule opt ['into word!]]
pre-post-rule: [group13 block!]
repeat-rule: ['repeat integer!]
postcondition-rule: [group14 block!]
secondary-rules1: [doing-rule | predicate-rule | return-rule | aggregation-rule | counting-rule]
secondary-rules2: [pre-post-rule | repeat-rule | postcondition-rule]

loop-rules: [
    opt named-rule
    [with-rule | for-as-rule]
    opt condition-rule
    opt some [secondary-rules1 | secondary-rules2]
]

;; Test parsing

test-cases: [
    [with test = 123]
    [for count upfrom 10]
    [for count from 10 downto 1 collect [print "Stuff"]]
    [for count from 10 downto 1 collect [print "Stuff"] into my-list until [false]]
    [named "Test" for count from 1 upto 10 do [print "Stuff"] repeat 5]
]

foreach test-case test-cases [
    unless parse test-case loop-rules [
        parse-trace test-case loop-rules
    ]
]

;; Parsing into context

;; Do stuff

