local range = function (number1, number2)
   local range_index = 0
   local current_number = number2 ~= nil and number1 - 1 or -1

   if number2 == nil then
      number2 = number1
   end

   return function ()
      range_index = range_index + 1
      current_number = current_number + 1
      if current_number <= number2 then
         return current_number
      end
   end
end

local zip_ranges = function (iter1, iter2)
   local new_table = {}
   local item1 = iter1()
   local item2 = iter2()
   while item1 ~= nil or item2 ~= nil do
      new_table[#new_table + 1] = { item1, item2 }
      item1 = iter1()
      item2 = iter2()
   end
   return new_table
end

for _, items in ipairs(zip_ranges(range(10), range(10, 20))) do
   print(items[1], items[2])
end
