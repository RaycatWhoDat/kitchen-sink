math.randomseed(("" .. os.time()):reverse())
math.random()

local utils = {}

function base_sample(t, number, is_nondestructive)
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

function utils.pick(t, number)
   return base_sample(t, number, true)
end

function utils.sample(t, number)
   return base_sample(t, number, false)
end

function utils.join(separator, ...)
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

function utils.trim(str)
   return string.match(str, "%s*(%S.+%S)%s*")
end

function utils.tee(...)
   local args = { ... }
   for index, arg in ipairs(args) do
      print(index, arg)
   end
   return unpack(args)
end

function utils.chars(str)
   local chars = {}
   for letter in string.gmatch(str, ".") do
      table.insert(chars, letter)
   end
   return chars
end

return utils
