from std/strutils import Digits, splitLines
from std/parseutils import parseInt, skipUntil
from std/compilesettings import querySetting, SingleValueSetting
import std/enumerate

const lines = staticRead("../README.md")

proc main =
  for index, line in enumerate(lines.splitLines()):
    var value: int
    let skippedCharacters = skipUntil(line, Digits)
    if skippedCharacters != 0 and skippedCharacters != line.len:
      discard line.parseInt(value, skippedCharacters)
      echo "L" & $index & ": " & $value
      echo "Context: " & line & "\n"

when isMainModule:
  main()
