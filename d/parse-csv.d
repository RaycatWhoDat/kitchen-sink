#!/usr/bin/env rdmd

module parsecsv;

import std.stdio: writefln, File;
import std.csv: csvReader;
import std.algorithm: each, joiner;
import std.typecons: Tuple;
import std.range.primitives: back;

void main(string[] args) {

  string filename = args.length > 1 ? args.back : "no_file.csv";
  auto csv_file = File(filename, "r");

  auto parsed_csv = csv_file
                    .byLine
                    .joiner("\n")
                    .csvReader!(Tuple!(string, string, string, string));
  
  parsed_csv.each!(record => writefln("%s, %s, %s, %s", record[0], record[1], record[2], record[3]));
    
}

// Local Variables:
// compile-command: "./parse-csv.d MOCK_DATA.csv"
// End:
