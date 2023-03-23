local utils = require "utils"
local Class = require "class"

Room = { number_of_rooms = 1 }
function Room:new(name, description, rooms)
   local newObject = {
      name = name,
      description = description or "Room #" .. tostring(self.number_of_rooms),
      rooms = rooms
   }

   self.number_of_rooms = self.number_of_rooms + 1
   
   return Class.new(self, newObject)
end

function Room:get_exits()
   local directions = { "NORTH", "SOUTH", "EAST", "WEST" }
   local exits = {}
   local expeditions = {}
   for index, direction in ipairs(directions) do
      if self.rooms[direction] == nil then
         table.insert(expeditions, direction)
      else
         table.insert(exits, direction)
      end
   end

   print("You may MOVE " .. utils.join("/", unpack(exits)) .. ".")
   print("You may EXPLORE " .. utils.join("/", unpack(expeditions)) .. ".")
end


return Room
