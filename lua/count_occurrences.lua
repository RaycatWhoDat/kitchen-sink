occurrences = 0
for line in string.gmatch(io.input("../awk/test-text.txt"):read("*a"), "TXR") do
   occurrences = occurrences + 1
end

print("Number of TXR occurrences: " .. occurrences)
