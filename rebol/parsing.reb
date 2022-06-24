REBOL []

file: read/string %../awk/test-text.txt
count: 0
txr-rules: [any [to "TXR" thru "TXR" (count: count + 1)]]
parse file txr-rules
print ["Number of TXR occurrences:" count]