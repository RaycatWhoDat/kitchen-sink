local lg, lk, le, la, lt = love.graphics, love.keyboard, love.event, love.audio, love.timer
local view = require("fennelview")
local lume = require("lume")
local flux = require("flux")
local player = {health = 1, radius = 0, speed = 100, x = 32, y = 32}
local ring = {opacity = 1, radius = 500}
local scene_key_map = {}
local movement_key_map = {a = {"x", -1}, d = {"x", 1}, s = {"y", 1}, w = {"y", -1}}
local gamestate = {["status-hooks"] = {}, draw = {}, keypressed = {}, load = {}, status = "STARTING", timers = {}, update = {}}
local gong = la.newSource("bowl.wav", "static")
local function register_callback(callback_type, callback)
  local function _0_()
    if callback_type then
      local number_of_callbacks = #gamestate[callback_type]
      local message = ("Added callback #" .. (number_of_callbacks + 1) .. " to '" .. callback_type .. "'.")
      return table.insert(gamestate[callback_type], callback)
    else
      return callback()
    end
  end
  _0_()
  return #gamestate[callback_type]
end
local function unregister_callback(callback_type, index)
  if index then
    return table.remove(gamestate[callback_type], index)
  else
    return table.remove(gamestate[callback_type])
  end
end
local function run_callbacks(list_of_callbacks, ...)
  for key, callback in pairs(list_of_callbacks) do
    local function _0_(...)
      if (type(callback) == "function") then
        return callback(unpack({...}))
      end
    end
    _0_(...)
  end
  return nil
end
local function set_gamestate_status(state)
  gamestate.status = state
  return run_callbacks(gamestate["status-hooks"])
end
local function quit_game()
  return set_gamestate_status("STOPPING")
end
local function move_player(axis, direction, dt)
  do
    local _0_ = {lg.getDimensions()}
    local width = _0_[1]
    local height = _0_[2]
    local new_value = (player[axis] + ((direction * (player.speed * player.health)) / 60))
    local function _1_()
      if not (gamestate.status == "COMPLETE") then
        player[axis] = new_value
        return nil
      end
    end
    _1_()
    local function _2_()
      if (((player.x + player.radius) < 0) or ((player.y + player.radius) < 0) or ((player.x - player.radius) > width) or ((player.y - player.radius) > height)) then
        return set_gamestate_status("COMPLETE")
      end
    end
    _2_()
  end
  player.health = lume.clamp((1 - ((lume.distance(player.x, player.y, ring.x, ring.y) - ring.radius) / (ring.radius * 1.1499999999999999))), 0, 1)
  if ((player.health <= 0.20000000000000001) and not (gamestate.status == "COMPLETE")) then
    flux.to(ring, 1, {opacity = (ring.opacity - 0.20000000000000001), radius = (ring.radius * 1.5)}):ease("cubicout")
    return flux.to(player, 0.5, {health = 1, radius = (player.radius * 0.90000000000000002), speed = (player.speed * 1.1000000000000001), x = ring.x, y = ring.y}):ease("cubicout")
  end
end
player.draw = function()
  lg.setColor(0.10000000000000001, 0.10000000000000001, 0.10000000000000001, player.health)
  lg.circle("fill", player.x, player.y, player.radius)
  return lg.setColor(0, 0, 0)
end
ring.draw = function()
  lg.setColor(0, 0, 0, ring.opacity)
  lg.circle("line", ring.x, ring.y, ring.radius)
  return lg.setColor(0, 0, 0)
end
local function scene_update(dt)
  flux.update(dt)
  for key, action in pairs(lume.extend(scene_key_map, movement_key_map)) do
    table.insert(action, dt)
    local function _0_()
      if (lk.isDown(key) and (ring.radius > player.radius)) then
        if (type(action) == "function") then
          return action()
        else
          return move_player(unpack(action))
        end
      end
    end
    _0_()
  end
  return nil
end
local function scene_draw()
  lg.setBackgroundColor(1, 1, 1)
  ring.draw()
  return player.draw()
end
local function scene_keypressed(key)
  if (key == "c") then
    return set_gamestate_status("COMPLETE")
  end
end
local main_scene = {draw = scene_draw, keypressed = scene_keypressed, update = scene_update}
local global_key_map = {}
love.keypressed = function(key)
  local function _0_()
    if (key == "p") then
      if (gamestate.status == "RUNNING") then
        return set_gamestate_status("PAUSED")
      else
        return set_gamestate_status("RUNNING")
      end
    end
  end
  _0_()
  local function _1_()
    if (key == "q") then
      return quit_game()
    end
  end
  _1_()
  return run_callbacks(gamestate.keypressed, key)
end
love.load = function()
  local function first_load()
    local function game_started()
      if (gamestate.status == "STARTED") then
        set_gamestate_status("RUNNING")
        return flux.to(player, 1, {radius = 28}):after(ring, 1, {radius = (32 * 1.1499999999999999)})
      end
    end
    register_callback("status-hooks", game_started)
    local function game_stopping()
      if (gamestate.status == "STOPPING") then
        return set_gamestate_status("STOPPED")
      end
    end
    register_callback("status-hooks", game_stopping)
    local function game_stopped()
      if (gamestate.status == "STOPPED") then
        return le.quit()
      end
    end
    register_callback("status-hooks", game_stopped)
    local function game_complete()
      if (gamestate.status == "COMPLETE") then
        la.play(gong)
        return flux.to(ring, 2, {opacity = 0})
      end
    end
    register_callback("status-hooks", game_complete)
    local function key_handler()
      for key, callback in pairs(global_key_map) do
        local function _0_()
          if (lk.isDown(key) and (type(callback) == "function")) then
            return callback()
          end
        end
        _0_()
      end
      return nil
    end
    register_callback("update", key_handler)
    local function upon_completion(dt)
      if ((gamestate.status == "COMPLETE") and gong:isPlaying()) then
        gong:setVolume((gong:getVolume() - (dt / 4)))
        if (gong:getVolume() <= 0.01) then
          gong:stop()
          return quit_game()
        end
      end
    end
    register_callback("update", upon_completion)
    do
      local _0_ = {lg.getDimensions()}
      local width = _0_[1]
      local height = _0_[2]
      ring.x = math.floor((width / 2))
      ring.y = math.floor((height / 2))
      player.x = ring.x
      player.y = ring.y
    end
    register_callback("update", main_scene.update)
    register_callback("draw", main_scene.draw)
    register_callback("keypressed", main_scene.keypressed)
    return set_gamestate_status("STARTED")
  end
  register_callback("load", first_load)
  return run_callbacks(gamestate.load)
end
love.update = function(dt)
  if not (gamestate.status == "PAUSED") then
    return run_callbacks(gamestate.update, dt)
  end
end
love.draw = function()
  return run_callbacks(gamestate.draw)
end
return love.draw
