package;

using Lambda;

typedef Card = {
  value: Int,
  suit: String
};

class DeckOfCards {
  public static var cards: Array<Card> = [];
  
  public static function generate() {
    cards = [
      for (value in 0...52)
      {
        value: (value % 13) + 1,
        suit: ["♥", "♦", "♠", "♣"][Math.floor(value / 13)]
      }
    ];
  }

  public static function prettyPrint(card: Card): String {
    return switch (card) {
      case { value: 1, suit: s }: "A" + s;
      case { value: 11, suit: s }: "J" + s;
      case { value: 12, suit: s }: "Q" + s;
      case { value: 13, suit: s }: "K" + s;
      case { value: v, suit: s }: v + s;
      case _: "Not a valid card.";
    }
  }
  
  public static function main() {
    DeckOfCards.generate();
    DeckOfCards.cards.iter(function (item) trace(DeckOfCards.prettyPrint(item)));
  }
}

// Local Variables:
// mode: funda-haxe
// eval: (setq funda-haxe-indent-offset 2)
// compile-command: "haxe -x DeckOfCards"
// End: