import std/parseutils

proc main =
  var file = open("../README.md", fmRead)
  defer: close(file)
  for line in file.lines:
    var value: int
    discard parseInt(line, value)
    echo line
    echo value

main()
