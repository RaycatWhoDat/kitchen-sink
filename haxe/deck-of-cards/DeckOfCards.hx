package;

using Lambda;

typedef Card = {
  value: Int,
  suit: Int
};

@:keep
class DeckOfCards {
  public static var cards: Array<Card> = [];

  public static function generate() {
    cards = [
      for (value in 0...52)
        {
          value: (value % 13) + 1,
          suit: (value % 4)
        }
    ];
  }

  public static function prettyPrint(card: Card): String {
    var suits = ["♥", "♦", "♠", "♣"];

    return switch (card) {
      case {value: 1, suit: s}: "A" + suits[s];
      case {value: 11, suit: s}: "J" + suits[s];
      case {value: 12, suit: s}: "Q" + suits[s];
      case {value: 13, suit: s}: "K" + suits[s];
      case {value: v, suit: s}: v + suits[s];
      case _: "Not a valid card.";
    }
  }

  public static function main() {
    DeckOfCards.generate();
    DeckOfCards.cards.iter(item -> trace(DeckOfCards.prettyPrint(item)));
  }
}

// Local Variables:
// compile-command: "haxe -x DeckOfCards"
// End:
