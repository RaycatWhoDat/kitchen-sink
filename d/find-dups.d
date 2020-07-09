module finddups;

void main() {
  import std.stdio, std.range, std.path, std.conv, std.algorithm;

  auto rawData = "~/Desktop/raw-data.txt".expandTilde.File.byLine;
  string[] usernames = [];
  
  foreach (line; rawData) {
    usernames ~= line.to!string.split(" ").front;
  }

  usernames
      .group
      .filter!(item => item[1] > 1)
      .each!(item => item[0].writeln);
}
