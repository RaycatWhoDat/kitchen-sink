import os
import sequtils
import strutils
import sugar

type Count[T] = tuple[value: T, occurrences: int]

proc group[T](sequence: seq[T]): seq[Count[T]] =
  var groupings: seq[Count[T]] = @[]
  for item in sequence.deduplicate:
    groupings.add((value: item, occurrences: sequence.count(item)))
  groupings
  
proc main() =
  var usernames: seq[string] = @[];
  for line in "~/Desktop/raw-data.txt".expandTilde.lines:
    usernames.add(line.split(" ")[0]);

  for grouping in usernames.group.filterIt(it.occurrences > 1):
    echo grouping[0]

when isMainModule:
  main()
