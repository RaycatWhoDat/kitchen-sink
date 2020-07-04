import sequtils
import strutils

let
  output = "final_conversion.csv".open(FileMode.fmAppend)
  numbers = toSeq("./formatted_numbers.txt".lines)
  texts = toSeq("./formatted_text.txt".lines)
  types = toSeq("./formatted_types.txt".lines)

for index in 1 .. numbers.len:
  var
    number = numbers[index - 1]
    text = texts[index - 1]
    kind = types[index - 1]
    
  output.writeLine("$1|$2|$3" % [number, text, kind])

output.close
