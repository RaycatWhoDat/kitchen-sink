import std/[times]
import options

type Card = ref object
  number: string
  cardholderName: string
  balance: float = 0.00
  ouncesPoured: float = 0.00
  
type ReaderEventType = enum
  INSERTED, CHARGED, REMOVED

type ReaderEvent = ref object
  eventType: ReaderEventType
  timestamp: int64 = getTime().toUnix()
  payload: string

type Reader = ref object
  currentCard: Option[Card] = none(Card)
  events: seq[ReaderEvent] = @[]

proc insertCard(reader: Reader, card: Card) =
  reader.events.add(ReaderEvent(eventType: INSERTED, payload: card.cardholderName))
  reader.currentCard = some(card)

proc chargeCard(reader: Reader, ouncesPoured: float, pricePerOunce: float) =
  var
    newCharge = ouncesPoured * pricePerOunce
    currentCard = reader.currentCard.get()

  reader.events.add(ReaderEvent(eventType: CHARGED, payload: $newCharge))
  currentCard.ouncesPoured += ouncesPoured
  currentCard.balance += newCharge
  
proc removeCard(reader: Reader, card: Card) =
  if reader.currentCard.isNone:
    return
    
  reader.events.add(ReaderEvent(eventType: REMOVED, payload: reader.currentCard.get().cardholderName))
  reader.currentCard = none(Card)

proc displayStats(reader: Reader) =
  var currentCard = reader.currentCard.get()
  echo "Cardholder name: ", currentCard.cardholderName
  echo "Ounces poured: ", currentCard.ouncesPoured
  echo "Balance: $", currentCard.balance
  
when isMainModule:
  var card = Card(number: "5555555555555555", cardholderName: "Ray Perry")
  var reader = Reader()

  reader.insertCard(card)
  reader.chargeCard(10.1, 0.79)
  reader.displayStats()
  reader.removeCard(card)
  
