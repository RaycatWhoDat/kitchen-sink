Red []

#system [
    minus-one: -1
    pointer-to-minus-one: :minus-one
]

print-message: routine [message [string!]] [
    print unicode/to-utf8 message pointer-to-minus-one
]
    
print-message "This is a test"

