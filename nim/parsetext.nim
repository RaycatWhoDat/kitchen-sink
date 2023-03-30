from std/strutils import Digits
from std/parseutils import parseInt, skipUntil
import std/enumerate

proc main =
  var file = open("../README.md", fmRead)
  defer: close(file)
  for index, line in enumerate(file.lines):
    var value: int
    let skippedCharacters = skipUntil(line, Digits)
    if skippedCharacters != 0 and skippedCharacters != line.len:
      discard line.parseInt(value, skippedCharacters)
      echo "L" & $index & ": " & $value
      echo "Context: " & line & "\n"

main()
