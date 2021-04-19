import fusion/matching

when isMainModule:
  {.experimental: "caseStmtMacros".}

  var testData = 1 .. 10

  case testData:
    of [1, @two, all _]:
      echo two
