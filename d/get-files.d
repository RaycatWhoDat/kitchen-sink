#!/usr/bin/env rdmd 

module getfiles;

import std.array: replace;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: indexOf;
import std.stdio: writeln;
import std.getopt;

enum IndentationLevel {
  TWO_SPACES = 2,
  FOUR_SPACES = 4
}

string[] ignoredPaths = ["/.git", "/node_modules", "/target"];

string generateIndent(int traversalLevel = 0) pure {
  string indentation = "";
  foreach (index; 0 .. IndentationLevel.TWO_SPACES * traversalLevel) indentation ~= " ";

  return indentation;
}

void printFiles(string directoryPath, int traversalLevel = 0) {
iterateOverFiles:
  foreach (entry; dirEntries(directoryPath, SpanMode.shallow)) {
    foreach (pathToIgnore; ignoredPaths) {
      if (indexOf(entry.name, pathToIgnore) >= 0) break iterateOverFiles;
    }
    writeln(generateIndent(traversalLevel), entry.name.replace(directoryPath, ""), entry.isDir ? "/" : "");
    if (entry.isDir) printFiles(entry.name ~ "/", traversalLevel + 1);
  }
}

void main(string[] args) {
  string directoryPath = getcwd();
  getopt(args, "directory", &directoryPath);
  printFiles(directoryPath);
}

// Local Variables:
// compile-command: "./get-files.d --directory .."
// End:
