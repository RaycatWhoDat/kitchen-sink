#!/usr/bin/env rdmd

module parsecsv;

import std.stdio;
import std.algorithm;
import std.range;
import std.csv;

int main(string[] args) {
  if (args.length != 2) return 1;

  auto csvFile = File(args.back)
                 .byLine
                 .joiner("\n")
                 .csvReader!(string[string])(null);

  auto allKeys = ["First Name", "Last Name", "Email", "Date of Birth"];
  
  foreach (record; csvFile) {
    allKeys.each!(key => writefln("%s: %s", key, record[key]));
    writeln();
  }
  
  return 0;
}

// Local Variables:
// compile-command: "./parse-csv.d MOCK_DATA.csv"
// End:
