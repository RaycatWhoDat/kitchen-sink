local class = require "pl.class"

local Card = class.Card()
function Card:_init(number, cardholder_name)
   self.number = number
   self.cardholder_name = cardholder_name
   self.balance = 0.0
   self.ounces_poured = 0.0
end

local ReaderEvent = class.ReaderEvent()
function ReaderEvent:_init(event_type, payload)
   self.event_type = event_type
   self.timestamp = os.date("%c")
   self.payload = payload
end

function ReaderEvent:__tostring()
   return string.format("%s - %s - %s", self.timestamp, self.event_type, self.payload)
end  

local Reader = class.Reader()
function Reader:_init()
   self.events = {}
end

function Reader:insert_card(card)
   table.insert(self.events, ReaderEvent("CHARGED", card.cardholder_name))
   self.current_card = card
end

function Reader:charge_card(ounces_poured, price_per_ounce)
   if not self.current_card then return end
   local charge = ounces_poured * price_per_ounce
   table.insert(self.events, ReaderEvent("CHARGED", string.format("$%.2f", charge)))
   self.current_card.ounces_poured = self.current_card.ounces_poured + ounces_poured
   self.current_card.balance = self.current_card.balance + charge
end

function Reader:remove_card()
   table.insert(self.events, ReaderEvent("REMOVED", self.current_card.cardholder_name))
   self.current_card = nil
end

function Reader:display_stats()
   if self.current_card then
      print(string.format("Cardholder: %s", self.current_card.cardholder_name))
      print(string.format("Total Amount: %s", self.current_card.balance))
      print(string.format("Ounces Poured: %s", self.current_card.ounces_poured))
   end
   print("\nEvents: ")
   for _, event in ipairs(self.events) do
      print(event)
   end
end

local card = Card("5555555555555555", "Ray Perry")
local reader = Reader()

reader:insert_card(card)
reader:charge_card(10.1, 0.79)
reader:remove_card()
reader:insert_card(card)
reader:display_stats()


