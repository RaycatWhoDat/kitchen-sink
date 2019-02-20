using haxe.Http;

class ScryfallSearch {
  static function main() {
    var query: String = StringTools.urlEncode("snea att").split("%20").join("+");
    var results: Array<Dynamic> = haxe.Json.parse(Http.requestUrl("https://api.scryfall.com/cards/search?q=" + query)).data;

    for (card in results) {
      Sys.println(card.name + ' ' + card.mana_cost);
      Sys.println(card.type_line);
      Sys.println(card.oracle_text);
    }

  }
}