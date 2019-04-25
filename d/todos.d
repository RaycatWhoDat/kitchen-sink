#!/usr/bin/env rdmd

module todos;

import std.stdio: File, writeln;
import std.file: DirEntry, dirEntries, getcwd, SpanMode;
import std.range: array;
import std.string: indexOf;
import std.getopt: getopt;

class Todo {
  DirEntry filePath;
  size_t lineNumber;
  string todoText;

  this(DirEntry filePath, size_t lineNumber, string todoText) {
    this.filePath = filePath;
    this.lineNumber = lineNumber;
    this.todoText = todoText;
  }
}

void main(string[] args) {
  string directoryPath = getcwd();
  getopt(args, "directory", &directoryPath);

  Todo[] allTodos = [];
  foreach (fileEntry; dirEntries(directoryPath, SpanMode.depth)) {
    if (fileEntry.isDir() || fileEntry.name.indexOf("todos.d") != -1) continue;

    string[] lines = File(fileEntry).byLineCopy().array();
    foreach (lineNumber, line; lines) {
      size_t foundIndex = line.indexOf("TODO");
      if (foundIndex == -1) continue;
      allTodos ~= new Todo(fileEntry, lineNumber + 1, line[foundIndex .. $]);
      writeln(fileEntry ~ " | " ~ line[foundIndex .. $]);
    }
  }
}

// Local Variables:
// compile-command: "./todos.d --directory ."
// End:
