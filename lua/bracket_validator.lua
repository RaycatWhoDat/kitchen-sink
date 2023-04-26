function validate(brackets)
   local bracket_mapping = { ["{"] = "}", ["["] = "]", ["("] = ")", [")"] = "(", ["]"] = "[", ["}"] = "{" }
   local expected_brackets = {}
   for bracket in string.gmatch(brackets, "([%{%[%(%)%]%}])") do
      if bracket == "["  or bracket == "(" or bracket == "{" then
         table.insert(expected_brackets, bracket_mapping[bracket])
      elseif bracket == "]"  or bracket == ")" or bracket == "}" then
         if bracket ~= table.remove(expected_brackets) then
            break
         end
      end
   end
   return #expected_brackets == 0
end
         
assert(validate("{[]()}") == true)
assert(validate("{[(])}") == false)
assert(validate("{[}") == false)


