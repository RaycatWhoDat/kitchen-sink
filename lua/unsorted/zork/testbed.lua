local utils = require "utils"
local Class = require "class"
local Room = require "room"
local GameMap = require "game_map"
local Player = require "player"

local seed_room = Room:new("Ye Olde Tavern", "There's nothing here but ale.")
local test_room = Room:new("The Other Room", "This is another room.", { SOUTH = seed_room })
seed_room.rooms = { NORTH = test_room }

local game_map = GameMap:new(seed_room)
local player = Player:new("TESTBOT")
player.current_room = game_map.starting_room

player:status()
player.current_room:get_exits()
