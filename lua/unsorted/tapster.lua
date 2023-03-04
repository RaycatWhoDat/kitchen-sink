require "zork/class"

local Card = {}
function Card:new(cardholder_name, number)
   return Class.new(self, {
         number = number,
         cardholder_name = cardholder_name,
         balance = 0,
         ounces_poured = 0
   })
end

local ReaderEvent = {}
function ReaderEvent:new(event_type, payload)
   return Class.new(self, {
         event_type = event_type,
         timestamp = os.date("%c"),
         payload = payload
   })
end

function ReaderEvent:__tostring()
   return "[" .. self.timestamp .. "] " .. self.event_type .. " - " .. self.payload
end

local Reader = {}
function Reader:new()
   return Class.new(self, {
         events = {}
   })
end

function Reader:insert_card(card)
   table.insert(self.events, ReaderEvent:new("INSERTED", card.cardholder_name))
   self.current_card = card
end

function Reader:charge_card(ounces_poured, price_per_ounce)
   if not self.current_card then
      return
   end
   charge = ounces_poured * price_per_ounce
   table.insert(self.events, ReaderEvent:new("CHARGED", charge))
   self.current_card.ounces_poured = self.current_card.ounces_poured + ounces_poured
   self.current_card.balance = self.current_card.balance + charge
end

function Reader:remove_card()
   table.insert(self.events, ReaderEvent:new("REMOVED", self.current_card.cardholder_name))
   self.current_card = nil
end

function Reader:display_stats()
   if self.current_card then
      print("Cardholder: " .. self.current_card.cardholder_name)
      print("Total Amount: " .. self.current_card.balance)
      print("Ounces Poured: " .. self.current_card.ounces_poured)
      print()
   end
   
   print("Events:")
   for _, event in ipairs(self.events) do
      print(event)
   end
end

local card = Card:new("Ray Perry", "5555555555555555")
local reader = Reader:new()

reader:insert_card(card)
reader:charge_card(10, 0.50)
reader:remove_card()
reader:display_stats()
