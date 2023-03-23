local Utils = require "utils"

local test_cases = { "lumberjacks", "background", "downstream", "six-year-old", "isograms" }

function is_isogram(str)
   local is_word_isogram = true
   local mapping = {}
   for letter in string.gmatch(str, "[^\ \-]") do
      if not mapping[letter] then
         mapping[letter] = true
      else
         is_word_isogram = false
         break
      end
   end
   return is_word_isogram
end

local expected_results = { true, true, true, true, false }
for index, test_case in ipairs(test_cases) do
   if is_isogram(test_case) == expected_results[index] then
      io.write("🟢")
   else
      io.write("🔴")
   end
end
io.flush()

