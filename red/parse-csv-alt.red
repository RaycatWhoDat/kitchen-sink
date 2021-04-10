Red [needs 'view]

#include %extra.red

csv-row: [collect [keep [first-name last-name email dob]]]
first-name: [keep to "," skip]
last-name: [keep to "," skip]
email: [keep to "," skip]
dob: [keep to end skip]

load-data: function [] [
    result: []
    foreach line at read/lines %MOCK_DATA.csv 2 [
        record: [first-name last-name email dob] ~ (parse line csv-row)
        append result rejoin [
            "First Name: " record/first-name newline
            "Last Name: " record/last-name newline
            "Email: " record/email newline
            "Date of Birth: " record/dob newline
        ]
    ]
    listing/data: result
]

window-size: 800x1024

view [
    size window-size
    title "Mock Data Listing"
    listing: text-list window-size data []
    do [load-data]
]
