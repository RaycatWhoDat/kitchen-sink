Red []

test-case: "Many hands make light work."
test-result: "TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu"

encoded-string: enbase test-case
print encoded-string
if encoded-string = test-result [
    print to string! debase encoded-string
]
