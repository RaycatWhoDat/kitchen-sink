module carnival;

void main() {
  import std.stdio;
  import std.algorithm;
  import std.range;
  import std.conv;

  auto firstFiveLetters = ["a", "b", "c", "d", "e"];
  auto lastFiveLetters = ["v", "w", "x", "y", "z"];

  auto numberGenerator = recurrence!("n + 1")(1).chunks(5);
  auto firstFiveNumbers = numberGenerator.front.map!(to!string);
  numberGenerator.popFront();
  auto nextFiveNumbers = numberGenerator.front.map!(to!string);

  firstFiveLetters
      .chain(lastFiveLetters, firstFiveNumbers, nextFiveNumbers)
      .each!writeln;
}

// Local Variables:
// compile-command: "rdmd container-carnival.d"
// End:
