Red []

do read https://raw.githubusercontent.com/RayMPerry/crimson/master/crimson.red

first-number: to-integer ask "Enter the first number: "
second-number: to-integer ask "Enter the second number: "
third-number: to-integer ask "Enter the third number: "
largest-number: crimson/max-of-series reduce [first-number second-number third-number]
print ["The largest number is:" largest-number]