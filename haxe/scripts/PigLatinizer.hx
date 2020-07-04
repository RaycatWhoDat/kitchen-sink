package;

// Requires Haxe >= 4.2.0

using Lambda;

function main() {
  inline function pigIt(sentence: String): String {
    return sentence.split(" ").map(word -> {
        var baseWord = word.substr(1) + word.substr(0, 1);
        return baseWord + (~/^[a-z]+$/i.match(word) ? "ay" : "");
      }).join(" ");
  };

  var testCases = ["This is a test", "Pig latin is cool", "Hello world !"];
  testCases.iter(testCase -> trace(pigIt(testCase)));
}

// Local Variables:
// compile-command: "haxe --run PigLatinizer.hx"
// End:
