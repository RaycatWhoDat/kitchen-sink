local result = io.popen("luarocks list"):read("*a")

local libs = {}
for match in string.gmatch(result, "([^%s]+)[%s]+%d+") do
   if match ~= "Lua" then
      table.insert(libs, match)
   end
end

print(string.format("Available libraries: %s", table.concat(libs, ", ")))
