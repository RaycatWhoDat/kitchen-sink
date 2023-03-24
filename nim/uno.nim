import std/[algorithm, random, sequtils, strformat, strutils, terminal, options]
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
  
type Card = object
  color: Option[Color]
  number: Option[int]
  effect: Option[Effect]

type Hand = object of RootObj
  cards: seq[Card]

type Deck = object of Hand

proc newDeck(): Deck =
  result = Deck(cards: @[])
  for color in Color:
    for number in 0..9:
      let newCard = Card(color: some(color), number: some(number), effect: none(Effect))
      let numberOfCopies = if number > 0: 2 else: 1
      result.cards = result.cards & repeat(newCard, numberOfCopies)
    for effect in Effect:
      case effect:
        of Skip, DrawTwo, Reverse:
          let newCard = Card(color: some(color), number: none(int), effect: some(effect))
          result.cards = result.cards & repeat(newCard, 2)
        else:
          break
  result.cards = result.cards & repeat(Card(color: none(Color), number: none(int), effect: some(Wild)), 4)
  result.cards = result.cards & repeat(Card(color: none(Color), number: none(int), effect: some(WildDrawFour)), 4)
  shuffle(result.cards)

proc printCard(card: Card) =
  var fgColor = fgBlack
  var bgColor = bgBlack
  var value: string
  case card.color:
    of Some(Red):
      bgColor = bgRed
    of Some(Yellow):
      bgColor = bgYellow
    of Some(Green):
      bgColor = bgGreen
    of Some(Blue):
      bgColor = bgBlue
    of None():
      bgColor = bgBlack
      fgColor = fgWhite

  case card.effect:
    of Some(Skip):
      value = "SK"
    of Some(DrawTwo):
      value = "D2"
    of Some(Reverse):
      value = "RE"
    of Some(Wild):
      value = "WI"
    of Some(WildDrawFour):
      value = "D4"
    of None():
      break

  case card.number:
    of Some(@number):
      value = $number
    of None():
      break

  styledEcho(styleBright, bgColor, fgColor, value, resetStyle)
  
when isMainModule:
  let deck = newDeck()
  let hand = Hand(cards: deck.cards[0..<7])
  for card in hand.cards:
    card.printCard()
