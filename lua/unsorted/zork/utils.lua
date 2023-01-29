local Utils = {}

function base_sample(t, number, opts)
   assert(number > 1, "Number cannot be less than 2.")
   local options = opts or {}
   local picks = {}
   local choice = -1
   for index = 1, (number or 2) do
      choice = math.random(#t)
      item = options.is_nondestructive and t[choice] or table.remove(t, choice)
      table.insert(picks, item)
   end
   return unpack(picks)
end

function Utils.pick(t, number)
   return base_sample(t, number, { is_nondestructive = true })
end

function Utils.sample(t, number)
   return base_sample(t, number)
end

function Utils.join(separator, ...)
   local strings = { ... }
   local new_string = ""
   for index, str in ipairs(strings) do
      new_string = new_string .. (type(str) ~= "string" and tostring(str) or str)
      if index < #strings then
         new_string = new_string .. (separator or " ")
      end
   end
   return new_string
end

function Utils.trim(str)
   return string.match(str, "%s*(%S.+%S)%s*")
end

function Utils.tee(...)
   local args = { ... }
   for index, arg in ipairs(args) do
      print(index, arg)
   end
   return unpack(args)
end

function Utils.chars(str)
   local chars = {}
   for letter in string.gmatch(str, ".") do
      table.insert(chars, letter)
   end
   return chars
end

function Utils.range(number1, number2)
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

function Utils.zip(...)
   local iters = { ... }
   local result = {}
   local is_exhausted
   
   repeat
      local tuple = {}
      is_exhausted = true
      for index = 1, #iters do
         local item = iters[index]()
         if item ~= nil then is_exhausted = false end
         table.insert(tuple, item)
      end
      table.insert(result, tuple)
   until is_exhausted
   
   return result
end

return Utils
