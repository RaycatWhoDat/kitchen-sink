import std/[math, strformat, times]
import options
from std/strutils import startsWith

when not startsWith(NimVersion, "2"):
  {.fatal: "This can only be run with Nim 2.x and greater." }

type Card = ref object
  number: string
  cardholderName: string
  balance: float = 0.00
  ouncesPoured: float = 0.00
  
type ReaderEventType = enum
  INSERTED, CHARGED, REMOVED

type ReaderEvent = ref object
  eventType: ReaderEventType
  timestamp: int64
  payload: string

proc newEvent(eventType: ReaderEventType, payload: string): ReaderEvent =
  ReaderEvent(eventType: eventType, timestamp: getTime().toUnix(), payload: payload)
  
proc `$`(event: ReaderEvent): string = fmt"{event.timestamp} - {event.eventType} - {event.payload}"
        
type Reader = ref object
  currentCard: Option[Card] = none(Card)
  events: seq[ReaderEvent] = @[]

proc insertCard(reader: Reader, card: Card) =
  reader.events.add(newEvent(INSERTED, card.cardholderName))
  reader.currentCard = some(card)

proc chargeCard(reader: Reader, ouncesPoured: float, pricePerOunce: float) =
  var
    newCharge = round(ouncesPoured * pricePerOunce, 2)
    currentCard = reader.currentCard.get()

  reader.events.add(newEvent(CHARGED, fmt"${newCharge}"))
  currentCard.ouncesPoured += round(ouncesPoured, 2)
  currentCard.balance += newCharge
  
proc removeCard(reader: Reader) =
  if reader.currentCard.isNone:
    return
    
  reader.events.add(newEvent(REMOVED, reader.currentCard.get().cardholderName))
  reader.currentCard = none(Card)

proc displayStats(reader: Reader) =
  if not reader.currentCard.isNone:
    var currentCard = reader.currentCard.get()
    echo "Cardholder name: ", currentCard.cardholderName
    echo "Ounces poured: ", currentCard.ouncesPoured
    echo "Balance: $", currentCard.balance

  for event in reader.events:
    echo event
  
when isMainModule:
  var card = Card(number: "5555555555555555", cardholderName: "Ray Perry")
  var reader = Reader()

  reader.insertCard(card)
  reader.chargeCard(10.1, 0.79)
  reader.removeCard()
  reader.insertCard(card)
  reader.displayStats()
  
