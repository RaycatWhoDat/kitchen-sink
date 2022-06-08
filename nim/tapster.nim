import std/[times]
import options

type Card = ref object
  number: string
  cardholderName: string
  balance: float
  ouncesPoured: float

proc newCard(number: string, cardholderName: string): Card =
  Card(number: number, cardholderName: cardholderName, balance: 0.00, ouncesPoured: 0.00)
  
type ReaderEventType = enum
  INSERTED, CHARGED, REMOVED

type ReaderEvent = ref object
  eventType: ReaderEventType
  timestamp: int64
  payload: string

proc newEvent(eventType: ReaderEventType, payload: string): ReaderEvent = 
  ReaderEvent(eventType: eventType, timestamp: getTime().toUnix(), payload: payload)
  
type Reader = ref object
  currentCard: Option[Card]
  events: seq[ReaderEvent]

proc newReader(): Reader =
  Reader(currentCard: none(Card), events: @[])

proc insertCard(reader: Reader, card: Card) =
  reader.events.add(newEvent(INSERTED, card.cardholderName))
  reader.currentCard = some(card)

proc chargeCard(reader: Reader, ouncesPoured: float, pricePerOunce: float) =
  var
    newCharge = ouncesPoured * pricePerOunce
    currentCard = reader.currentCard.get()

  reader.events.add(newEvent(CHARGED, $newCharge))
  currentCard.ouncesPoured += ouncesPoured
  currentCard.balance += newCharge
  
proc removeCard(reader: Reader, card: Card) =
  if reader.currentCard.isNone:
    return
    
  reader.events.add(newEvent(REMOVED, reader.currentCard.get().cardholderName))
  reader.currentCard = none(Card)

proc displayStats(reader: Reader) =
  var currentCard = reader.currentCard.get()
  echo "Cardholder name: ", currentCard.cardholderName
  echo "Ounces poured: ", currentCard.ouncesPoured
  echo "Balance: $", currentCard.balance
  
when isMainModule:
  var card = newCard("5555555555555555", "Ray Perry")
  var reader = newReader()

  reader.insertCard(card)
  reader.chargeCard(10.1, 0.79)
  reader.displayStats()
  reader.removeCard(card)
  
