-- -*- mode: Lua; compile-command: "love ../radial-menu" -*-

lg = love.graphics
le = love.event

function love.load()
   menu = {
      activeItem = 1,
      numberOfItems = 13,
      radius = 100,
      itemSeparation = 100,
      xOffset = 0,
      yOffset = lg.getHeight() - 50,
      rotationSpeed = 50
   }
   items = {}
   itemDrawables = {}

   local numberOfItems = menu.numberOfItems
   for i = 1, numberOfItems do
      local angle = i * (2 * math.pi / numberOfItems) + menu.itemSeparation
      local itemX = menu.radius * math.cos(angle) + menu.xOffset
      local itemY = menu.radius * math.sin(angle) + menu.yOffset
      
      items[#items + 1] = 'test' .. i
      itemDrawables[#itemDrawables + 1] = {
         color = {
            math.random(0, 255),
            math.random(0, 255),
            math.random(0, 255)
         },
         x = itemX,
         y = itemY,
         width = 20,
         height = 40
      }
   end
   
end

function love.update(dt)
   for i = 1, #itemDrawables do
      local currentItem = itemDrawables[i]
      local angle = i * (2 * math.pi / menu.numberOfItems) + menu.itemSeparation
      local c = math.cos(angle)
      local s = math.sin(angle)
      local r = menu.radius

      local rotatedX = currentItem.x
      local rotatedY = currentItem.y

      -- rotatedX = rotatedX - currentItem.x
      -- rotatedY = rotatedY - currentItem.y
      
      local newX = currentItem.x * (r * c) - (currentItem.y * (r * s)) - (menu.rotationSpeed * dt)
      local newY = currentItem.y * (r * s) + (currentItem.x * (r * c)) + (menu.rotationSpeed * dt)
      
      rotatedX = rotatedX + newX
      rotatedY = rotatedY + newY

      -- currentItem.x = rotatedX
      -- currentItem.y = rotatedY
   end   
end

function love.keypressed(key)
   if key == 'escape' then le.quit() end
   if key == 'left' then
      local newIndex = menu.activeItem - 1
      if newIndex < 1 then newIndex = #items end
      menu.activeItem = newIndex
   end
   if key == 'right' then
      local newIndex = menu.activeItem + 1
      if newIndex > #items then newIndex = 1 end
      menu.activeItem = newIndex
   end
end


function love.draw()
   -- lg.setColor({ unpack(menu.itemColors[menu.activeItem]), 100 });
   -- lg.draw('fill', 10, 10, 10, 30)
   for i = 1, #itemDrawables do
      local currentItem = itemDrawables[i]
      lg.setColor(currentItem.color)
      lg.rectangle('fill', currentItem.x, currentItem.y, currentItem.width, currentItem.height)
   end
   
   lg.setColor(255, 255, 255)
end
