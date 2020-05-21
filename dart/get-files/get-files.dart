import "dart:io";

final TWO_SPACES = 2;
final IGNORED_PATHS = [".git", "dist", "love", "node_modules", "target", "dub", "_build"];

void getFiles([String directoryPath = ".", int traversalLevel = 0]) {
  var currentDirectory = Directory(directoryPath);
  var indentation = " " * (TWO_SPACES * traversalLevel);
  var fileListing = currentDirectory.listSync();

  fileListing.sort((file1, file2) => file1.path.compareTo(file2.path));

  fileListing.forEach((file) {
    var currentEntry = file.path.split("/").last;
    stdout.writeln("$indentation${currentEntry}");
    if (file is File || IGNORED_PATHS.contains(currentEntry)) return;
    getFiles(file.path, traversalLevel + 1);
  });
}

void main(List<String> arguments) {
  getFiles(arguments.first ?? ".");
}
