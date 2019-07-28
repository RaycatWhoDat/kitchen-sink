#!/usr/bin/env rdmd 

module getfiles;

import std.algorithm: canFind;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: replace, join;
import std.stdio: writeln;
import std.getopt: getopt;
import std.range: repeat;

const string INDENTATION_CHARACTER = " ";
const int TWO_SPACES = 2, FOUR_SPACES = 4;

string[] ignoredPaths = [".git", "node_modules", "target", "love", "dist", ".dub", "build", "_build"];

void printFiles(string directoryPath, int traversalLevel = 0) {
  foreach (entry; dirEntries(directoryPath, SpanMode.shallow)) {
    string currentEntry = entry.name.replace(directoryPath, "");
    if (ignoredPaths.canFind(currentEntry.replace("/", ""))) continue;
    repeat(INDENTATION_CHARACTER, TWO_SPACES * traversalLevel)
        .join("")
        .writeln(currentEntry);
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
