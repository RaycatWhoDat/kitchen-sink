str = "go "
matches = "go "

if (string.gmatch(matches, "%a")) then
   local fragment = ""
   matches:gsub(".", function (character)
      fragment = fragment .. character
      print(str .. fragment)
   end)
end

-- Local Variables:
-- compile-command: "lua ./lh001.lua"
-- End:
