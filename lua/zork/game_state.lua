local utils = require "utils"
local GameMap = require "game_map"
local Player = require "player"

local directions = { "NORTH", "EAST", "SOUTH", "WEST" }

local explore_command = "EXPLORE (%a+)"
local move_command = "MOVE (%a+)"
local system_command = "EXIT"

GameState = {}
function GameState:new(game_map, player)
   local game_state = Class.new(self, {
      game_map = game_map,
      player = player,
      last_command = nil
   })

   game_state.player.current_room = game_map.starting_room
   return game_state
end

function GameState:handle_commands()
   self.player:status()
   self.player.current_room:get_exits()

   local next_input = nil
   local next_direction = nil
   repeat
      print("What is your command? ")
      _, next_input = pcall(io.read)
      _, next_input = pcall(utils.trim, next_input)
      _, next_input = pcall(string.upper, next_input)
   until next_input ~= nil

   next_direction = string.match(next_input, move_command)
   if next_direction ~= nil then
      self.player.current_room = self.player.current_room.rooms[next_direction]
   end

   next_direction = string.match(next_input, explore_command)
   if next_direction ~= nil then
      self.player.current_room = self.game_map:generate_unexplored_room(self.player.current_room, next_direction)
   end

   if string.match(next_input, system_command) ~= nil then
      os.exit(0)
   end

   self.last_command = next_input
end

return GameState
   
