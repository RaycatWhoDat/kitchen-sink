module filesplitter;

void main() {
  import std.stdio, std.file, std.format, std.range, std.array;

  foreach (index, line; "../MOCK_DATA.csv".File.byLine.array) {
    File(format("line%s.txt", index), "w").writeln(line);
  }
}
