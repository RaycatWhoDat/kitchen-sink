lg = love.graphics
lk = love.keyboard
le = love.event

function love.load()
   healthCanvas = lg.newCanvas();

   health = 100
end

function love.update(dt)
   if lk.isDown("up") then health = health + 1 end
   if lk.isDown("down") then health = health - 1 end
end

function love.keypressed(key)
   if key == "q" then le.quit() end
end

function firstCircle()
   lg.setColor(1,0,0)
   lg.circle("fill", 100, 100, 50)
   -- lg.setColor(1,0,0,1)
   -- lg.circle("line", 100, 100, 50)
   lg.setColor(1,1,1)
   lg.print(health, 90, 90);
end

function secondCircle()
   lg.setColor(0,1,0)
   lg.circle("fill", 100, 100, 50)
   -- lg.setColor(0,1,0,1)
   -- lg.circle("line", 100, 100, 50)
   lg.setColor(0,0,0)
   lg.print(health, 90, 90);
   lg.setColor(1,1,1)
end

function createImageMask(percentage)
   return function()
      lg.rectangle("fill", 45, 45, 110, 110 * (1 - (percentage / 100)))
   end
end

function love.draw()
   lg.setCanvas({ healthCanvas, stencil = true })
   lg.stencil(createImageMask(health), "replace", 1)
   secondCircle()
   lg.setStencilTest("greater", 0)
   firstCircle()
   lg.setStencilTest();
   lg.setCanvas();

   lg.draw(healthCanvas);
end

-- Local Variables:
-- compile-command: "love ."
-- End:
