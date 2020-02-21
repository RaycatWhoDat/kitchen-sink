module capitalize;

import std.stdio: writeln;
import std.array: split, join;
import std.algorithm: each, map;
import std.ascii: toUpper;
import std.conv: text;  
import std.range: front, back;

string capitalizeFirstLast(string input) {  
  return input
      .split(" ")
      .map!(word => text(word.front.toUpper, word[1..$-1], word.back.toUpper))
      .join(" ");
}

void main() {
  auto testCases = ["whatever", "whatever you", "whatever you want", "yeah man"];
  
  testCases
      .map!capitalizeFirstLast
      .each!writeln;
}

// Local Variables:
// compile-command: "rdmd capitalize.d"
// End:
