import strformat
import sequtils
import algorithm
import loopfusion

let
  fdata = toSeq("../MOCK_DATA.csv".lines)
  rdata = toSeq("../MOCK_DATA.csv".lines).reversed

for fline, rline in zip(fdata, rdata):
  var file = &"line{index}.txt".open(fmWrite)
  file.writeLine(fline)
  file.writeLine(rline)
  
