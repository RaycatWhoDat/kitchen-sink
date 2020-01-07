using haxe.Http;
using Lambda;

class ScryfallSearch {
  static function main() {
    var query: String = StringTools.urlEncode(Sys.args().join(" ")).split("%20").join("+");

    if (query.length <= 0) {
      trace("No cards found.");
      return;
    }

    var searchRequest = Http.requestUrl("https://api.scryfall.com/cards/search?q=" + query);
    var parsedResults: Array<Dynamic> = haxe.Json.parse(searchRequest).data;

    if (parsedResults.length <= 0) {
      trace("No cards found.");
      return;
    }

    function printCard(cardFace, ?otherCardFace) {
      Sys.print(cardFace.name + " ");
      cardFace.mana_cost != null ? Sys.println(cardFace.mana_cost) : Sys.println("");
      if (otherCardFace != null) Sys.println('(This card transforms into ${otherCardFace.name}.)');
      Sys.println(cardFace.type_line);
      Sys.println(cardFace.oracle_text);

      if (cardFace.power != null || cardFace.toughness != null) {
        Sys.println(cardFace.power + "/" + cardFace.toughness);
      }
      Sys.println("");
    }

    for (card in parsedResults) {
      if (card.card_faces != null && card.card_faces.length > 1) {
        printCard(card.card_faces[0], card.card_faces[1]);
        printCard(card.card_faces[1], card.card_faces[0]);
      } else {
        printCard(card);
      }
    }
  }
}