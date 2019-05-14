local lg, lk, le, la, lt = love.graphics, love.keyboard, love.event, love.audio, love.timer
local lume = require("lume")
player = {height = 32, width = 16, x = 0, y = 0}
local scene_key_map = {}
local movement_key_map = {down = {"y", 1}, left = {"x", -1}, right = {"x", 1}, up = {"y", -1}}
local function move_player(directional_table)
  local _0_ = unpack(directional_table)
  local axis = _0_[1]
  local direction = _0_[2]
  print(player[axis])
  player[axis] = (player[axis] + direction)
  return nil
end
player.draw = function()
  lg.setColor(1, 0, 1, 0.34999999999999998)
  lg.rectangle("fill", player.x, player.y, player.width, player.height)
  lg.setColor(1, 0, 1, 1)
  lg.rectangle("line", player.x, player.y, player.width, player.height)
  return lg.setColor(1, 1, 1)
end
local function scene_update(dt)
  for key, action in pairs(lume.extend(scene_key_map, movement_key_map)) do
    local function _0_()
      if lk.isDown(key) then
        if (type(action) == "function") then
          return action()
        else
          return move_player(action)
        end
      end
    end
    _0_()
  end
  return nil
end
local function scene_draw()
  return player.draw()
end
local function scene_keypressed(key)
end
return {draw = scene_draw, keypressed = scene_keypressed, update = scene_update}
