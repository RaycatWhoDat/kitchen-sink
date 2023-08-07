local test_case1 = "((()()))"
local test_case2 = "(()()"
local test_case3 = "((()(((((())())))()))()"

print(test_case1:find("%b()"))
print(test_case2:find("%b()"))
print(test_case3:find("%b()"))

