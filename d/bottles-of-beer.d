#!/usr/bin/env rdmd

module beer;

import std.algorithm;
import std.range;
import std.stdio;
import std.getopt;
import std.conv;

// 99 bottles of beer on the wall, 99 bottles of beer.
// Take one down and pass it around, 98 bottles of beer on the wall.

// 1 bottle of beer on the wall, 1 bottle of beer.
// Go to the store and buy some more, 99 bottles of beer on the wall.
 
auto pluralize = (int number) => (number > 1) ? "bottles" : "bottle";

string getVerse(int startingNumber, int remainingBottles) {
  int currentNumber = remainingBottles > 1 ? remainingBottles - 1 : startingNumber;
  return remainingBottles.to!string()
      ~ " "
      ~ pluralize(remainingBottles)
      ~ " of beer on the wall, "
      ~ remainingBottles.to!string()
      ~ " "
      ~ pluralize(remainingBottles)
      ~ " of beer.\n"
      ~ ((remainingBottles > 1) ? "Take one down and pass it around, " : "Go to the store and buy some more, ")
      ~ currentNumber.to!string()
      ~ " "
      ~ pluralize(currentNumber)
      ~ " of beer on the wall.";
}
      
void main(string[] args) {
  if (args.length <= 0) return;

  int bottlesOfBeer = 10;
  getopt(args, "bottles", &bottlesOfBeer);

  iota(bottlesOfBeer, 0, -1)
      .each!(remainingBottles => writeln(getVerse(bottlesOfBeer, remainingBottles)));
}
