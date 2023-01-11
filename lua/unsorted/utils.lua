math.randomseed((''..os.time()):reverse())
math.random()

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

local function base_sample(t, number, is_nondestructive)
   assert(number > 1, "Number cannot be less than 2.")
   local picks = {}
   local choice = -1
   for index = 1, (number or 2) do
      choice = math.random(#t)
      item = is_nondestructive and t[choice] or table.remove(t, choice)
      table.insert(picks, item)
   end
   return unpack(picks)
end

local function pick(t, number)
   return base_sample(t, number, true)
end

local function sample(t, number)
   return base_sample(t, number, false)
end

local test_case1 = { 1, 2, 3, 4, 5 }
local test_case2 = { 6, 7, 8, 9, 10, 11 }
local test_case3 = { 12, 13, 14, 15, 16, 17, 18 }

for item1, item2, item3, item4, item5 in zip(test_case1, test_case2, test_case3, test_case2, test_case1) do
   print(item1, item2, item3, item4, item5)
end

print(pick(test_case3, 2))
print(#test_case3)
print(sample(test_case3, 2))
print(#test_case3)

-- {
--    zip = zip
-- }
