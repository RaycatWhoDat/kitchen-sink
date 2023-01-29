local utils = require "utils"

print(utils.trim("      This is a test        "))

local range1 = utils.range(10)
local range2 = utils.range(10, 21)
local range3 = utils.range(21, 33)

for _, items in ipairs(utils.zip(range1, range2, range3)) do
   print(unpack(items))
end

