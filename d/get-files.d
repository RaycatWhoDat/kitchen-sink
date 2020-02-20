#!/usr/bin/env rdmd 

module getfiles;

import std.algorithm: canFind;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: replace, join;
import std.stdio: writeln;
import std.range: repeat;
import std.path: dirSeparator;
import std.getopt;

const string INDENTATION_CHARACTER = " ";
const int TWO_SPACES = 2, FOUR_SPACES = 4;

string[] ignoredPaths = [".git", "node_modules", "target", "love", "dist", ".dub", "build", "_build"];
string directoryPath;
bool isRecursive = false;

void printFiles(string directoryPath, int traversalLevel = 0) {
  foreach (entry; directoryPath.dirEntries(SpanMode.shallow)) {
    string currentEntry = entry.name;
    if (directoryPath != ".") {
      currentEntry = currentEntry.replace(directoryPath, "").replace(dirSeparator, "");
    }
    
    if (ignoredPaths.canFind(currentEntry)) continue;

    INDENTATION_CHARACTER
        .repeat(TWO_SPACES * traversalLevel)
        .join("")
        .writeln(currentEntry);

    if (isRecursive && entry.isDir) entry.name.printFiles(traversalLevel + 1);
  }
}

void main(string[] args) {
  directoryPath = getcwd();

  getopt(args,
         std.getopt.config.passThrough,
         "directory", &directoryPath,
         "recursive", &isRecursive);

  directoryPath.printFiles();
}

// Local Variables:
// compile-command: "./get-files.d"
// End:
