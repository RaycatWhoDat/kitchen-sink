local GameState = require "game_state"

local seed_room = Room:new("Ye Olde Tavern", "There's nothing here but ale.")
local test_room = Room:new("The Other Room", "This is another room.", { SOUTH = seed_room })
seed_room.rooms = { NORTH = test_room }

local game_map = GameMap:new(seed_room)
local player = Player:new("TESTBOT")
player.current_room = game_map.starting_room
local game_state = GameState:new(game_map, player)

local is_game_complete = false

repeat
   game_state:handle_commands()
until is_game_complete
