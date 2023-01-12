local utils = require "utils"
local Room = require "room"

GameMap = {}
function GameMap:new(starting_room)
   return Class.new(self, { starting_room = starting_room })
end

function GameMap:get_opposing_direction(direction)
   return ({
      NORTH = "SOUTH",
      EAST = "WEST",
      SOUTH = "NORTH",
      WEST = "EAST"
   })[direction]
end

function GameMap:generate_unexplored_room(previous_room, direction)
   local name = utils.join("", utils.pick(utils.chars("abcdefghijklmnopqrstuvwxyz"), 15))
   local opposite_direction = self:get_opposing_direction(direction)
   local new_room = Room:new(name, nil, { [opposite_direction] = previous_room })
   previous_room.rooms[direction] = new_room
   return new_room
end

return GameMap
