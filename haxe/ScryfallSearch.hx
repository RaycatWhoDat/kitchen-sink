using haxe.Http;

class ScryfallSearch {
  static function main() {
    var query: String = StringTools
                        .urlEncode("sne attack")//Sys.args().join(" "))
                        .split("%20")
                        .join("+");

    if (query.length <= 0) {
      trace("No cards found.");
      return;
    }
    
    // var results: Array<Dynamic> = haxe.Json.parse(Http.requestUrl("https://api.scryfall.com/cards/search?q=" + query)).data;

    var results: Array<Dynamic> = haxe.Json.parse(Http.requestUrl("https://jsonplaceholder.typicode.com/posts"));

    if (results.length <= 0) {
      // trace("No cards found.");
      return;
    }
    
    // for (card in results) {
    //   Sys.println(card.name + " " + card.mana_cost);
    //   Sys.println(card.type_line);
    //   Sys.println(card.oracle_text);
      
    //   if (card.power != null || card.toughness != null) {
    //     Sys.println(card.power + "/" + card.toughness);
    //   }
    // }

    for (post in results) {
      Sys.println(post.id + " | " + post.userId);
      Sys.println("");
      Sys.println(post.title);
      Sys.println(post.body);
      Sys.println("");
    }
  }
}