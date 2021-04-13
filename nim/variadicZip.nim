import sugar
import sequtils
import fusion/matching

when isMainModule:
  {. experimental: "caseStmtMacros" .}
  
  var
    testData1 = [1, 2, 3]
    testData2 = [4, 5, 6]
    testData3 = [7, 8, 9, 10, 11, 12]
    
  let result = collect(newSeq):
    for item in testData1.zip(testData2).zip(testData3):
      case item:
        of ((@first, @second), @third):
          (first, second, third)

  for item in result:
    echo item
