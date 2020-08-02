void main() {
  import std.stdio, std.range, std.algorithm, std.variant;
  import std.random, std.container, std.array, std.conv;
  import mir.combinatorics;
  import mir.ndslice.fuse;

  auto names = ["Syd", "Sabrina", "Veronica", "Sean", "Karan", "Ray"];
  auto allCombinations = names.combinations(2).fuse;
  allCombinations.writeln;
  // auto pairs = allCombinations.randomSample(3);
  
  // while (!names.setDifference(pairs.joiner).empty) {
  //   pairs = names.combinations(2).randomSample(3);
  // }

  // foreach (pair; pairs) {
  //   pair.writeln;
  // }
}
