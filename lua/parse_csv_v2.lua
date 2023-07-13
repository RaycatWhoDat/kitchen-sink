local index = 0
for line in io.lines("../d/MOCK_DATA.csv") do
   index = index + 1
   for first_name, last_name, email, dob in string.gmatch(line, "(.+),(.+),(.+),(.+)") do
      if index ~= 1 then
         print(string.format("%20s %20s %30s %10s", first_name, last_name, email, dob))
      end
   end
end
