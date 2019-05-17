local lg = love.graphics
local lk = love.keyboard
local le = love.event

local player = {}

function resetPlayer()
   player = {
      x = 0,
      y = 0,
      width = 32,
      height = 32,
      speed = 128,
      color = {
         r = 255,
         b = 0,
         g = 0
      }
   }
end

function toggleColor()
   if player.color.r > 0 then
      player.color.r = 0
      player.color.g = 255
   elseif player.color.g > 0 then
      player.color.g = 0
      player.color.b = 255
   elseif player.color.b > 0 then
      player.color.b = 0
      player.color.r = 255
   end
end

function love.load()
   resetPlayer()
end

function love.keypressed(key)
   if key == "escape" then
      le.quit()
   end

   if key == "return" then
      resetPlayer()
   end

   if key == "space" then
      toggleColor()
   end
end

function love.update(dt)
   if lk.isDown("left") and (player.x - (player.speed * dt) > 0) then
      player.x = player.x - (player.speed * dt)
   end
   if lk.isDown("right") and (player.x + player.width + (player.speed * dt) < 320) then
      player.x = player.x + (player.speed * dt)
   end
   if lk.isDown("up") and (player.y - (player.speed * dt) > 0) then
      player.y = player.y - (player.speed * dt)
   end
   if lk.isDown("down") and (player.y + player.height + (player.speed * dt) < 240) then
      player.y = player.y + (player.speed * dt)
   end
end

function love.draw()
   lg.setColor((player.color.r / 255), (player.color.g / 255), (player.color.b / 255), 100 / 255)
   lg.rectangle("fill", player.x, player.y, player.width, player.height)
   lg.setColor((player.color.r / 255), (player.color.g / 255), (player.color.b / 255))
   lg.rectangle("line", player.x, player.y, player.width, player.height)
   lg.setColor(1, 1, 1, 1)
end

-- Local Variables:
-- compile-command: "love ."
-- End:
