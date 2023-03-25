import std/[algorithm, lists, random, sequtils, strformat, strutils, terminal, options]
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

type DiscardPile = ref object
  topCard: Card
  
proc newDeck(): Deck =
  result = Deck(cards: @[], counter: 0)
  # Generate non-Wild cards
  for color in Color:
    for number in 0..9:
      let newCard = Card(color: some(color), number: some(number), effect: none(Effect), isPlayable: false)
      let numberOfCopies = if number > 0: 2 else: 1
      result.cards = result.cards & repeat(newCard, numberOfCopies)
    for effect in Effect:
      let newCard = Card(color: some(color), number: none(int), effect: some(effect), isPlayable: false)
      case effect:
        of Skip, DrawTwo, Reverse:
          result.cards = result.cards & repeat(newCard, 2)
        else:
          break
  # Add the Wilds
  let wildCard = Card(color: none(Color), number: none(int), effect: some(Wild), isPlayable: false)
  let wildDrawFourCard = Card(color: none(Color), number: none(int), effect: some(WildDrawFour), isPlayable: false)
  result.cards = result.cards & cycle(@[wildCard, wildDrawFourCard], 4)
  shuffle(result.cards)
  
proc drawCard(deck: Deck): Card =
  result = deck.cards[deck.counter]
  deck.counter = if deck.counter >= deck.cards.len(): 0 else: deck.counter + 1

proc discardToPile(card: Card, discardPile: DiscardPile) =
  if card.color.isNone:
    # Assign color
    card.color = some(Red)
  discardPile.topCard = card
  
proc newHand(deck: Deck): Hand =
  result = Hand(cards: @[])
  for index in 0..<7:
    result.cards.add(deck.drawCard())
  
proc printCard(card: Card) =
  var fgColor = fgBlack
  var bgColor = bgBlack
  var value: string
  case card.color:
    of Some(@color):
      bgColor = parseEnum[BackgroundColor]("bg" & $color)
    of None():
      bgColor = bgBlack
      fgColor = fgWhite

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
    of None():
      break

  stdout.styledWrite(styleBright, bgColor, fgColor, " ", value, " ", resetStyle)

proc checkIfPlayable(card: Card, discardPile: DiscardPile) =
  card.isPlayable = card.color.isNone or (card.effect.isSome and card.effect == discardPile.topCard.effect) or (card.number.isSome and card.number == discardPile.topCard.number) or card.color == discardPile.topCard.color
  
proc status(hand: Hand, discardPile: DiscardPile) =
  stdout.writeLine("=== " & $hand.cards.len() & " cards left ===")
  for card in hand.cards:
    card.checkIfPlayable(discardPile)
    card.printCard()
    if card.isPlayable:
      stdout.write("*")
    stdout.write("|")
  echo ""

proc status(discardPile: DiscardPile) =
  stdout.writeLine("=== Top card is: ===")
  discardPile.topCard.printCard()
  echo ""
    
when isMainModule:
  let deck = newDeck()
  let hand = newHand(deck)
  let discardPile = DiscardPile(topCard: nil)
  deck.drawCard().discardToPile(discardPile)
  discardPile.status()
  hand.status(discardPile)

