Red []

json: read/lines %stack-trace.json

delimiter: rejoin [dbl-quote ":"]
terminator: [dbl-quote | "]" | "}" | end]
key: [thru dbl-quote keep to delimiter 3 skip]
value: [thru dbl-quote keep to terminator]

foreach line json [
    matches: parse line [collect [key value]]
    print matches
]
