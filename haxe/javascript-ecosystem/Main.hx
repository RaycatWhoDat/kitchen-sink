import Lodash.*;

class Main {
  public static function main() {
    var testNumber = 123.4567;

    var testObject = {
      test1: {
        test2: {},
        test3: [1, 2, 3]
      }
    };

    trace(testNumber);
    trace(round(testNumber, 2));

    trace(testObject.test1.test3);
    trace(get(testObject, ["test1", "test4"], 1337));
    trace(get(testObject, "test1.test3", 1338));
  }
}
// Local Variables:
// compile-command: "haxe --cwd ../.. JavascriptEcosystem.hxml"
// End:
