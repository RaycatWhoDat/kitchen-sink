#!/usr/bin/env rdmd 

module getfiles;

import std.array: replace, join;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: indexOf;
import std.stdio: writeln;
import std.getopt;
import std.range: generate, take, array;
import std.regex: regex, matchFirst;

enum IndentationLevel {
  TWO_SPACES = 2,
  FOUR_SPACES = 4
}

auto ignoredPaths = regex("/(.git|node_modules|target|love)");

string generateIndent(int traversalLevel = 0) pure {
  return generate(() => " ").take(IndentationLevel.TWO_SPACES * traversalLevel).array().join("");
}

void printFiles(string directoryPath, int traversalLevel = 0) {
iterateOverFiles:
  foreach (entry; dirEntries(directoryPath, SpanMode.shallow)) {
    if (!directoryPath.matchFirst(ignoredPaths).empty) break iterateOverFiles;
    writeln(traversalLevel.generateIndent(), entry.name.replace(directoryPath, ""), entry.isDir ? "/" : "");
    if (entry.isDir) printFiles(entry.name ~ "/", traversalLevel + 1);
  }
}

void main(string[] args) {
  string directoryPath = getcwd();
  getopt(args, "directory", &directoryPath);
  directoryPath.printFiles();
}

// Local Variables:
// compile-command: "./get-files.d --directory .."
// End:
