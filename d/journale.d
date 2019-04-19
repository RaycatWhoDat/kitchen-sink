#!/usr/bin/env rdmd

module journale;

import std.file: append;
import std.stdio: readln, writeln;
import std.format: format;
import std.datetime.systime: Clock;

void main(string[] args) {
  string journalFileName = "./journal.org";
  writeln("What happened today?");
  journalFileName.append(format("[%s] %s", Clock.currTime().toLocalTime(), readln()));
}

// Local Variables:
// compile-command: "./journale.d"
// End:
