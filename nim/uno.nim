import std/[random, sequtils, strformat, strutils, terminal, options]
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

proc checkIfPlayable(card: Card, discardPile: DiscardPile) =
  card.isPlayable = card.color.isNone or (card.effect.isSome and card.effect ==
      discardPile.topCard.effect) or (card.number.isSome and card.number ==
      discardPile.topCard.number) or card.color == discardPile.topCard.color
  
proc newDeck(): Deck =
  result = Deck(cards: @[], counter: 0)
  # Generate non-Wild cards
  for color in Color:
    for number in 0..9:
      let newCard = Card(color: some(color), number: some(number), effect: none(
          Effect), isPlayable: false)
      let numberOfCopies = if number > 0: 2 else: 1
      result.cards = result.cards & repeat(newCard, numberOfCopies)
    for effect in Effect:
      let newCard = Card(color: some(color), number: none(int), effect: some(
          effect), isPlayable: false)
      case effect:
        of Skip, DrawTwo, Reverse:
          result.cards = result.cards & repeat(newCard, 2)
        else:
          break
  # Add the Wilds
  let wildCard = Card(color: none(Color), number: none(int), effect: some(Wild),
      isPlayable: false)
  let wildDrawFourCard = Card(color: none(Color), number: none(int),
      effect: some(WildDrawFour), isPlayable: false)
  result.cards = result.cards & cycle(@[wildCard, wildDrawFourCard], 4)
  shuffle(result.cards)
  
proc drawCard(deck: Deck, discardPile: DiscardPile): Card =
  result = deck.cards[deck.counter]
  result.checkIfPlayable(discardPile)
  if deck.counter >= deck.cards.len():
    deck.counter = 0
    shuffle(deck.cards)
  else:
    deck.counter += 1

proc discardToPile(card: Card, discardPile: DiscardPile) =
  if card.color.isNone:
    # Assign color
    card.color = some(Red)
  discardPile.topCard = card

proc newHand(deck: Deck, discardPile: DiscardPile): Hand =
  result = Hand(cards: @[])
  for index in 0..<7:
    result.cards.add(deck.drawCard(discardPile))

proc printCard(card: Card) =
  var bgColor = bgBlack
  var fgColor = fgWhite
  var value: string
  case card.color:
    of Some(@color):
      bgColor = parseEnum[BackgroundColor]("bg" & $color)
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
  let discardPile = DiscardPile(topCard: Card(color: none(Color), number: none(int), effect: none(Effect)))
  let hand = newHand(deck, discardPile)
  deck.drawCard(discardPile).discardToPile(discardPile)
  discardPile.status()
  hand.status(discardPile)

