local inspect = require("inspect")
local http_request = require("http.request")
local JSON = require("JSON")

local ERR_NO_CARDS = "No cards found."

-- From the lua-wiki...
function url_encode(str)
   if str then
      str = str:gsub("\n", "\r\n")
      str = str:gsub("([^%w %-%_%.%~])", function(c)
         return ("%%%02X"):format(string.byte(c))
      end)
      str = str:gsub(" ", "+")
   end
   return str	
end
----

function no_cards_found()
   print(ERR_NO_CARDS)
   os.exit()
end

function print_card(card_face, other_card_face)
   print(card_face.name .. " " .. card_face.mana_cost)
   if other_card_face ~= nil then print("(This card transforms into " .. other_card_face.name .. ".)") end
   print(card_face.type_line)

   if card_face.oracle_text ~= nil then
      print(card_face.oracle_text)
   else
      io.write("\n")
   end

   if card_face.power ~= nil or card_face.toughness ~= nil then
      io.write(card_face.power ~= nil and card_face.power or "-")
      io.write("/")
      print(card_face.toughness ~= nil and card_face.toughness or "-")
   end
   
   io.write("\n")
end


if #arg <= 0 then no_cards_found() end
local query = url_encode(arg[1])

local headers, stream = assert(http_request.new_from_uri("https://api.scryfall.com/cards/search?q=" .. query):go())
local body = assert(stream:get_body_as_string())
if headers:get ":status" ~= "200" then error(body) end

local results = JSON:decode(body).data

for _, card in ipairs(results) do
   if card.card_faces ~= nil then
      print_card(card.card_faces[1], card.card_faces[2])
      print_card(card.card_faces[2], card.card_faces[1])
   else
      print_card(card)
   end
end


