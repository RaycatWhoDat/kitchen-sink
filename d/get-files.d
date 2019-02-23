#!/usr/bin/env rdmd 

module getfiles;

import std.array: replace;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: indexOf;
import std.stdio: writeln;
import std.getopt;

int indentationLevel = 2;
int traversalLevel = -1;
string[] ignoredPaths = ["/.git", "/node_modules", "/target"];

string generateIndent(int traversalLevel = 0) {
  string indentation = "";
  foreach (index; 0..(indentationLevel * traversalLevel)) {
    indentation ~= " ";
  }
  return indentation;
}

void printFiles(string directoryPath = getcwd()) {
  traversalLevel += 1;
  foreach (entry; dirEntries(directoryPath, SpanMode.shallow)) {
    bool isPathIgnorable = false;
    foreach (pathToIgnore; ignoredPaths) {
      if (indexOf(entry.name, pathToIgnore) >= 0) isPathIgnorable = true;
    }
    if (isPathIgnorable) break;
    writeln(generateIndent(traversalLevel), entry.name.replace(directoryPath, ""), entry.isDir ? "/" : "");
    if (entry.isDir) printFiles(entry.name ~ "/");
  }
  traversalLevel -= 1;
}

void main(string[] args) {
  string directoryPath;
  getopt(args, "directory", &directoryPath);
  printFiles(directoryPath);
}

// Local Variables:
// compile-command: "./get-files.d --directory .."
// End:
