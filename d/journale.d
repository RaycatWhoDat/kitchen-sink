#!/usr/bin/env rdmd

module journale;

import std.file: append, exists;
import std.stdio: readln, writeln;
import std.format: format;
import std.datetime.systime: SysTime, Clock;

void main(string[] args) {
  string journalFileName = "./journal.org";
  
  writeln("What happened today?");
  string entryLine = readln();
  SysTime currentTime = Clock.currTime();

  append(journalFileName, format("[%s] %s", currentTime.toLocalTime(), entryLine));
}

// Local Variables:
// compile-command: "rdmd ./journale.d"
// End:
