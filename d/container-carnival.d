module carnival;

import std.stdio;
import std.algorithm;
import std.range;

auto next(T)(Chunks!T r) {
  auto previousResult = r.take(1);
  r.popFront();
  return previousResult;
}

void main() {
  auto firstFiveLetters = ["a", "b", "c", "d", "e"];
  auto lastFiveLetters = ["v", "w", "x", "y", "z"];

  auto numberGenerator = recurrence!("n + 1")(1).chunks(5);
  auto firstFiveNumbers = numberGenerator.next;
  auto nextFiveNumbers = numberGenerator.next; // I want this to be 6 7 8 9 10.

  writefln("%(%s %)", firstFiveLetters);
  writefln("%(%s %)", lastFiveLetters);
  writefln("%(%s %)", firstFiveNumbers);
  writefln("%(%s %)", nextFiveNumbers);
}

// Local Variables:
// compile-command: "rdmd container-carnival.d"
// End:
