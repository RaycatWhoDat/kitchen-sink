local key = "-----.....----"

function encode(number)
   local result = ""
   for digit in string.gmatch(tostring(number), "%d") do
      local formatted_digit = tonumber(digit)
      result = result .. string.sub(key, formatted_digit, formatted_digit + 5)
   end
   return result
end

function decode(code)
   local result = ""
   for index = 1, #code, 5 do
      local digit = string.find(key, string.sub(code, index, index + 4), 1, true)
      if not digit then break end
      result = result .. (digit - 1)
   end
   return tonumber(result)
end

print(encode(1203))
print(decode("-----.....-----.....-----"))
