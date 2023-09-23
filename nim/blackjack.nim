import std/[algorithm, random, strformat, strutils]

randomize()

type BlackjackValue = array[2, int]

type Card = object
  displayString: string
  value: BlackjackValue

type BlackjackDeck = object
  startingHandSize: int
  cards: seq[Card]
    
type BlackjackHand = object
  cards: seq[Card]
  total: BlackjackValue

proc status(hand: BlackjackHand) =
  for card in hand.cards:
    write(stdout, &"{card.displayString} ")
  write(stdout, "\n")
  flushFile(stdout)
  echo &"{hand.total[0]} {hand.total[1]}"

proc hit(hand: var BlackjackHand, card: Card) =
  hand.cards.add(card)
  hand.total[0] += card.value[0]
  hand.total[1] += card.value[1]

proc reset(deck: var BlackjackDeck) =
  deck.cards = @[]
  for chars in product([@["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"], @["♥", "♠", "♦", "♣"]]):
    var value =
      case chars[0]:
        of "A":
          [1, 11]
        of "10", "J", "Q", "K":
          [10, 10]
        else:
          [parseInt(chars[0]), parseInt(chars[0])]
    deck.cards.add(Card(displayString: chars.join(), value: value))
  deck.cards.shuffle()

proc hit(deck: var BlackjackDeck): Card =
  deck.cards.pop()
  
proc main() =
  var playerHand = BlackjackHand(cards: @[], total: [0, 0])
  var deck = BlackjackDeck(cards: @[], startingHandSize: 2)
  deck.reset()
  while playerHand.total[0] < 21:
    playerHand.hit(deck.hit())
    playerHand.status()

  echo "You've busted!"


main()
