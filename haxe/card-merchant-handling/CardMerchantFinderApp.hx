package;

#if unittest
import Sure.sure;
#end

using Lambda;
using StringTools;
using CardMerchantFinderApp.CardTestingUtils;

enum abstract MerchantType(String) {
  var VISA = "VS";
  var MASTERCARD = "MS";
  var AMERICAN_EXPRESS = "AX";
  var DISCOVER = "DS";
}

@:keep
class CardTestingUtils {
  public static function makeValid(cardNumber: String): String {
    var lastDigits = Math.floor(Math.random() * 999999) + 100;
    return cardNumber.replace("X", "0") + lastDigits;
  }
}

@:keep
class CardMerchantFinder {
  public static function getMerchant(cardNumber: String): Null<MerchantType> {
    return switch (cardNumber.split("").slice(0,6)) {
      case ["4", _, _, _, _, _]: MerchantType.VISA;

      case ["3", "4" | "7", _, _, _, _]: MerchantType.AMERICAN_EXPRESS;

      case ["2", "7", "0" | "1" | "2", _, _, _]: MerchantType.MASTERCARD;
      case ["2", "3" | "4" | "5" | "6", _, _, _, _]: MerchantType.MASTERCARD;
      case ["5", "1" | "2" | "3" | "4" | "5", _, _, _, _]: MerchantType.MASTERCARD;
      case ["2", "2", "2", digit, _, _] if (digit != "0"): MerchantType.MASTERCARD;
      case ["2", "2", digit, _, _, _] if (!["0", "1"].has(digit)): MerchantType.MASTERCARD;

      case ["3", "5", "2", "8", _, _]: MerchantType.DISCOVER;
      case ["3", "6" | "8" | "9", _, _, _, _]: MerchantType.DISCOVER;
      case ["6", "2", "2" | "4" | "5" | "6", _, _, _]: MerchantType.DISCOVER;
      case ["3", "0", "9", "5", _, _] | ["8", "1", _, _, _, _]: MerchantType.DISCOVER;
      case ["6", "0", "1", "1", _, _] | ["6", "5", _, _, _, _]: MerchantType.DISCOVER;
      case ["3", "0", "0" | "1" | "2" | "3" | "4" | "5", _, _, _]: MerchantType.DISCOVER;
      case ["6", "2", "8", digit, _, _] if (!["0", "1", "9"].has(digit)): MerchantType.DISCOVER;
      case ["3", "5", digit, _, _, _] if (!["0", "1", "2", "9"].has(digit)): MerchantType.DISCOVER;
      case ["6", "4", digit, _, _, _] if (!["0", "1", "2", "3"].has(digit)): MerchantType.DISCOVER;

      default: null;
    }
  }
}

class CardMerchantFinderApp {
  public static function main() {
    #if unittest
    sure({
        CardMerchantFinder.getMerchant("2221XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2222XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2223XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2224XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2225XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2226XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2227XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2228XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2229XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("223XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("224XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("225XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("226XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("227XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("228XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("229XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("23XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("24XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("25XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("26XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("270XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("271XXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("2720XXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("300XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("301XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("302XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("303XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("304XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("305XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("3095XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("34XXXXXXXX".makeValid()) == MerchantType.AMERICAN_EXPRESS;
        CardMerchantFinder.getMerchant("3528XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("353XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("354XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("355XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("356XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("357XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("358XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("36XXXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("37XXXXXXXX".makeValid()) == MerchantType.AMERICAN_EXPRESS;
        CardMerchantFinder.getMerchant("38XXXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("39XXXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("4XXXXXXXXX".makeValid()) == MerchantType.VISA;
        CardMerchantFinder.getMerchant("4XXXXXXXXX".makeValid()) == MerchantType.VISA;
        CardMerchantFinder.getMerchant("51XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("52XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("53XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("54XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("55XXXXXXXX".makeValid()) == MerchantType.MASTERCARD;
        CardMerchantFinder.getMerchant("6011XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("622XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("624XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("625XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("626XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6282XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6283XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6284XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6285XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6286XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6287XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("6288XXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("644XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("645XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("646XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("647XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("648XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("649XXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("65XXXXXXXX".makeValid()) == MerchantType.DISCOVER;
        CardMerchantFinder.getMerchant("81XXXXXXXX".makeValid()) == MerchantType.DISCOVER;
      });
    #end
  }
}

// Local Variables:
// compile-command: "haxe -D unittest -L sure -main CardMerchantFinderApp --interp"
// End: