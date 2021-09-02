Red []

number-of-items: 3
number-of-spaces: 10
headers: ["Last" "First" "Salary"]

print-row: function [items] [
    print [
        pad items/1 number-of-spaces
        pad items/2 number-of-spaces
        pad items/3 number-of-spaces
    ]
]

print-separator: does [
    separator: "-"
    repeat index number-of-spaces * number-of-items [prin separator]
    prin newline
]

records: read/lines %data/salaries.txt
field-rule: [keep to [comma | newline | end] skip]

all-employees: collect [
    forall records [
        keep parse records/1 [collect [some field-rule]]
    ]
]

sort/skip/compare all-employees 3 3

print-row headers
print-separator

foreach [last first salary] all-employees [
    print-row reduce [last first salary]
]