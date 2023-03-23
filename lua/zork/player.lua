local Room = require "room"

Player = {}
function Player:new(name, level, current_room)
   return Class.new(self, {
      name = name,
      level = level or 1,
      current_room = current_room
   })
end

function Player:status()
   print("You are " .. self.name .. ", a Level " .. self.level .. " adventurer.")
   print("You are currently in " .. self.current_room.name .. ".")
   if self.current_room.description then
      print(self.current_room.description)
   end
end

return Player
