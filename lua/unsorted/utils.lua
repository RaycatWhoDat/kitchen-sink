local function zip(...)
   local index = 0
   local items = { ... }
   return function ()
      index = index + 1
      local container = {}
      for _, item in ipairs(items) do
         table.insert(container, item[index])
      end
      return unpack(container)
   end
end

local test_case1 = { 1, 2, 3, 4, 5 }
local test_case2 = { 6, 7, 8, 9, 10, 11 }
local test_case3 = { 12, 13, 14, 15, 16, 17, 18 }

for item1, item2, item3, item4, item5 in zip(test_case1, test_case2, test_case3, test_case2, test_case1) do
   print(item1, item2, item3, item4, item5)
end

-- {
--    zip = zip
-- }