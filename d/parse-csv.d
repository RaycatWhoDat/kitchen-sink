#!/usr/bin/env rdmd

module parsecsv;

import std.stdio: writefln, File;
import std.algorithm: each;
import std.range: split, back;

int main(string[] args) {
  if (args.length != 2) return 1;
  File(args.back, "r")
      .byLine
      .each!(record => writefln("%(%s, %)", record.split(',')));

  return 0;
}

// Local Variables:
// compile-command: "./parse-csv.d MOCK_DATA.csv"
// End:
