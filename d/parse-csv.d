#!/usr/bin/env rdmd

module parsecsv;

import std.stdio: writefln, File;
import std.algorithm: each;
import std.range: split, back;

void main(string[] args) {
  string filename = args.length > 1 ? args.back : "no_file.csv";
  File(filename, "r")
      .byLine()
      .each!(record => writefln("%(%s, %)", record.split(',')));
}

// Local Variables:
// compile-command: "./parse-csv.d MOCK_DATA.csv"
// End:
