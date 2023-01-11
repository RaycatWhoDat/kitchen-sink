local result = 0
for letter in ("abcbacabcaaaaa"):gmatch(".") do
    result = result + ({ a = 1, b = 0, c = -1 })[letter]
end
print(result)