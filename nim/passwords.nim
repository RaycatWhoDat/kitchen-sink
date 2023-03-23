import re

proc checkRegex(s: string, r: Regex): bool =
  var matches: seq[string] = @[]
  s.contains(r, matches, 0)

type
  ValidUsername {.explain.} = concept s
    s.checkRegex(re"^\w+$")
  ValidPassword {.explain.} = concept s
    s.checkRegex(re"^\w{8,}$")

var username: ValidUsername = "username"
var password: ValidPassword = "password"
