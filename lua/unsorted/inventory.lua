InventoryItem = {}
function InventoryItem:new(id, name, price)
   newObj = { id = id, name = name, price = price }
   self.__index = self
   return setmetatable(newObj, self)
end

StoreEvent = {}
function StoreEvent:new(event_type, payload)
   newObj = {
      event_type = event_type,
      timestamp = os.date("%c"),
      payload = payload
   }
   self.__index = self
   return setmetatable(newObj, self)
end

Store = {}
function Store:new(name)
   newObj = {
      name = name,
      opening_time = 900,
      closing_time = 1700,
      stock = {},
      events = {}
   }
   self.__index = self
   return setmetatable(newObj, self)
end

function Store:update_item_quantity(item, amount)
   self.stock[item.id] = amount
end

function Store:purchase_item(item)
   if self.stock[item.id] < 1 then return end
   table.insert(self.events, StoreEvent:new("PURCHASED", item.id))
   self:update_item_quantity(item, self.stock[item.id] - 1)
end

function Store:refund_item(item)
   table.insert(self.events, StoreEvent:new("REFUNDED", item.id))
   self:update_item_quantity(item, self.stock[item.id] + 1)
end

item1 = InventoryItem:new("1", "Item 1 - A", 500)
item2 = InventoryItem:new("2", "Item 2 - B", 750)
item3 = InventoryItem:new("3", "Item 3 - C", 1000)

store = Store:new("Bob's Shop")

store:update_item_quantity(item1, 10)
store:update_item_quantity(item2, 7)
store:update_item_quantity(item3, 5)

store:purchase_item(item1)

for id, stock in pairs(store.stock) do
   print(id, stock)
end

for _, event in ipairs(store.events) do
   print(event.timestamp, event.event_type, event.payload)
end

