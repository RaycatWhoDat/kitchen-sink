void main() {
  import std.stdio, std.range;

  auto numbers = "formatted_numbers.txt".File.byLine;
  auto texts = "formatted_text.txt".File.byLine;
  auto types = "formatted_types.txt".File.byLine;

  auto output = File("final_conversion.csv", "a");
  
  foreach (line; zip(numbers, texts, types)) {
    output.writefln("%s|%s|%s", line.expand);
  }

  output.close;
}
