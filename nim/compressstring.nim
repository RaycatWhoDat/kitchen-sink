proc compressString(startingString: string): string =
  var lastCharacter = ""
  var occurrences = 0
  for character in startingString:
    if lastCharacter != $character:
      if lastCharacter.len > 0:
        result &= lastCharacter & $occurrences
      lastCharacter = $character
      occurrences = 0
    occurrences += 1
  result &= lastCharacter & $occurrences

echo compressString("aabcccccaaa")
