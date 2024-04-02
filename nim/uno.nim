import std/[parsecsv, random, sequtils, strutils, terminal, options]
import fusion/matching

{.experimental: "caseStmtMacros".}

randomize()

type Color = enum
  Red
  Yellow
  Green
  Blue

type Effect = enum
  Reverse
  Skip
  DrawTwo
  Wild
  WildDrawFour

type Card = ref object
  color: Option[Color]
  number: Option[int]
  effect: Option[Effect]
  isPlayable: bool

type Hand = object of RootObj
  cards: seq[Card]

type Deck = ref object of Hand
  counter: int
  lastPlayedCard: Card

proc newDeck(): Deck =
  result = Deck(cards: @[], counter: 0, lastPlayedCard: Card())
  var csvParser: CsvParser
  csvParser.open("cards.csv")
  csvParser.readHeaderRow()
  while csvParser.readRow():
    let newCard = Card()
    case csvParser.headers:
      of [@quantityColumn, @colorColumn, @numberColumn, @effectColumn]:
        let quantityValue = csvParser.rowEntry(quantityColumn).strip()
        let colorValue = csvParser.rowEntry(colorColumn).strip()
        let numberValue = csvParser.rowEntry(numberColumn).strip()
        let effectValue = csvParser.rowEntry(effectColumn).strip()
        newCard.color = if colorValue != "None": some(parseEnum[Color](colorValue)) else: none(Color)
        newCard.number = if numberValue != "None": some(parseInt(numberValue)) else: none(int)
        newCard.effect = if effectValue != "None": some(parseEnum[Effect](effectValue)) else: none(Effect)
        result.cards = result.cards & cycle(@[newCard], parseInt(quantityValue))
  csvParser.close()
  result.cards.shuffle()

proc checkIfPlayable(card: Card, deck: Deck) =
  card.isPlayable = card.color.isNone or (card.effect.isSome and card.effect ==
      deck.lastPlayedCard.effect) or (card.number.isSome and card.number ==
      deck.lastPlayedCard.number) or card.color == deck.lastPlayedCard.color

proc drawCard(deck: Deck): Card =
  result = deck.cards[deck.counter]
  result.checkIfPlayable(deck)
  if deck.counter >= deck.cards.len():
    deck.counter = 0
    shuffle(deck.cards)
  else:
    deck.counter += 1

proc newHand(deck: Deck): Hand =
  result = Hand(cards: @[])
  for index in 0..<7:
    result.cards.add(deck.drawCard())

let deck = newDeck()
let hand = deck.newHand()

proc discardCard(card: Card) =
  if card.color.isNone:
    # Assign temporary color to Wilds
    card.color = some(Red)
  deck.lastPlayedCard = card

proc printCard(card: Card) =
  var bgColor = bgBlack
  var fgColor = fgWhite
  var value: string
  if card.color.isSome:
    var color = card.color.get
    bgColor = parseEnum[BackgroundColor]("bg" & $color)
    if color == Yellow:
      fgColor = fgBlack

  case card.effect:
    of Some(Skip):
      value = "SK"
    of Some(DrawTwo):
      value = "+2"
    of Some(Reverse):
      value = "RE"
    of Some(Wild):
      value = "WI"
    of Some(WildDrawFour):
      value = "+4"

  case card.number:
    of Some(@number):
      value = " " & $number

  stdout.styledWrite(styleBright, bgColor, fgColor, " ", value, " ", resetStyle)

proc printGameStatus() =
  stdout.writeLine("=== Top card is: ===")
  deck.lastPlayedCard.printCard()
  echo ""
  stdout.writeLine("=== Your hand has " & $hand.cards.len() & " cards left ===")
  for card in hand.cards:
    card.checkIfPlayable(deck)
    card.printCard()
    if card.isPlayable:
      stdout.write("*")
    stdout.write("|")
  echo ""

deck.drawCard().discardCard()
printGameStatus()
