local starting_hand_size = 2
local number_of_players = 1

math.randomseed(os.time())
math.random()

Class = {}
function Class.new(new_self, new_obj)
   new_self.__index = new_self
   return setmetatable(new_obj, new_self)
end

BlackjackValue = {}
function BlackjackValue:new(display_value, first_value, second_value)
   self.__tostring = self.display_value
   return Class.new(self, {
     display_value = display_value,
     first_value,
     second_value
   })
end

BlackjackHand = {}
function BlackjackHand:new(cards)
   local total = { 0, 0 }
   for _, card in ipairs(cards) do
      total[1] = total[1] + card[1]
      total[2] = total[2] + card[2]
   end
   return Class.new(self, { cards = cards or {}, total = total })
end

function BlackjackHand:status()
   local card_listing = ""
   for _, card in ipairs(self.cards) do
      card_listing = card_listing .. " " .. card.display_value
   end

   print("Cards:" .. card_listing)
   first_total, second_total = unpack(self.total)
   print("Total value: " .. first_total .. (second_total ~= first_total and (", " .. second_total) or ""))
end

function BlackjackHand:hit(deck)
   local card = deck:hit()
   table.insert(self.cards, card)
   self.total[1] = self.total[1] + card[1]
   self.total[2] = self.total[2] + card[2]
end

function BlackjackHand:is_busted()
   return self.total[1] > 21 and self.total[2] > 21
end

BlackjackDeck = {}
function BlackjackDeck:new()
   new_deck = Class.new(self, { cards = {} })
   new_deck:reset()
   return new_deck
end

function BlackjackDeck:reset()
   local values = {
      "2", "3", "4", "5", "6", "7", "8",
      "9", "10", "J", "Q", "K", "A"
   }
   local suits = { "♥", "♠", "♦", "♣" }

   for _, suit in ipairs(suits) do
      for _, value in ipairs(values) do
         local first_value, second_value
         if value == "A" then
            first_value = 1
            second_value = 11
         else
            first_value = tonumber(value) or 10
            second_value = first_value
         end

         table.insert(self.cards, BlackjackValue:new(value .. suit, first_value, second_value))
      end
   end
end

function BlackjackDeck:deal()
   local cards = {}
   for index = 1, starting_hand_size * (number_of_players + 1) do
      local card = table.remove(self.cards, math.random(#self.cards))
      local current_player = (index % (number_of_players + 1)) + 1
      cards[current_player] = cards[current_player] or {} 
      table.insert(cards[current_player], card)
   end

   return cards
end

function BlackjackDeck:hit()
   return table.remove(self.cards, math.random(#self.cards))
end

local deck = BlackjackDeck:new()
local player_hand = BlackjackHand:new(deck:deal()[1])
player_hand:status()

repeat
   player_hand:hit(deck)
   player_hand:status()
until player_hand:is_busted()

print("You've busted!")
     
