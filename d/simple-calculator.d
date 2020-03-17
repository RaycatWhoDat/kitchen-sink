module calculator;

import std.array;
import std.stdio;
import std.algorithm;
import std.conv;
import std.string;

void main() {
  writeln("Enter a list of numbers separated by spaces:");
  auto numbers = readln()
                 .tr("0-9", " ", "c")
                 .split(" ")
                 .filter!(item => item != "")
                 .map!(to!double);
  
  writeln(numbers.sum());
}
