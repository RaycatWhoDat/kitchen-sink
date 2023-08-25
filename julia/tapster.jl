using Dates: datetime2epochms, now
using Printf

const CardNumber = String

mutable struct Card
    cardholderName::String
    number::CardNumber
    balance::Real
    ouncesPoured::Real
end

@enum ReaderEventType INSERTED=1 CHARGED REMOVED

struct ReaderEvent
    eventType::ReaderEventType
    timestamp::Int
    payload::String
end

ReaderEvent(eventType::ReaderEventType, payload::String) = ReaderEvent(eventType, datetime2epochms(now()), payload)

mutable struct Reader
    currentCard::Union{Card, Nothing}
    events::Array{ReaderEvent}
end

function insertCard(reader::Reader, card::Card)
    push!(reader.events, ReaderEvent(INSERTED, card.cardholderName))
    reader.currentCard = card
end

function removeCard(reader::Reader)
    push!(reader.events, ReaderEvent(REMOVED, reader.currentCard.cardholderName))
    reader.currentCard = nothing
end

function chargeCard(reader::Reader, ouncesPoured::Real, pricePerOunce::Real)
    if reader.currentCard == nothing return end
    charge = ouncesPoured  * pricePerOunce
    push!(reader.events, ReaderEvent(CHARGED, "$(charge)"))
    reader.currentCard.balance += charge
    reader.currentCard.ouncesPoured += ouncesPoured
end

function displayStats()
    for event in reader.events
        @printf "%s - %s - %s\n" event.timestamp event.eventType event.payload
    end
end

card = Card("Ray Perry", "5555555555555555", 0, 0)
reader = Reader(nothing, [])

insertCard(reader, card)
chargeCard(reader, 10, 0.5)
removeCard(reader)
insertCard(reader, card)
displayStats()
    

