function split(line, separator)
   local results = {}
   for item in string.gmatch(line, "%s*([^".. separator .. "]+)" .. separator .. "?") do
      table.insert(results, item)
   end
   return #results, unpack(results)
end

for line in io.lines("../d/MOCK_DATA.csv") do
   number_of_results, first_name, last_name, email, dob = split(line, ",")
   print(first_name, last_name, email, dob)
end
