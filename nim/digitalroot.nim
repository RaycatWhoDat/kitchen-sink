import std/[strutils, sequtils]

proc getDigitalRoot(startingNumber: string, startingDigitalRoot: int): int =
  var digitalRoot = startingDigitalRoot
  for character in toSeq(startingNumber.items):
    digitalRoot += parseInt($character)
  if digitalRoot > 10:
    return getDigitalRoot(intToStr(digitalRoot), 0)
  else:
    return digitalRoot

when isMainModule:
  var originalNumber = "12345678"
  echo getDigitalRoot(originalNumber, 0)
