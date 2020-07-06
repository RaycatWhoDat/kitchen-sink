void main() {
  import std.stdio, std.range, std.algorithm;

  auto numbers = "formatted_numbers.txt".File.byLine;
  auto texts = "formatted_text.txt".File.byLine;
  auto types = "formatted_types.txt".File.byLine;

  auto output = File("final_conversion.csv", "a");
  scope(exit) output.close;

  zip(numbers, texts, types)
      .each!(line => output.writefln("%s|%s|%s", line.expand));
}
