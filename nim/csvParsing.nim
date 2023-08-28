import std/[strformat, parsecsv]
import fusion/matching

var p: CsvParser
p.open("../d/MOCK_DATA.csv")
p.readHeaderRow()
while p.readRow():
  discard matches(p.row, [@firstName, @lastName, @email, @dob])
  echo fmt"{firstName}, {lastName}, {email}, {dob}"
