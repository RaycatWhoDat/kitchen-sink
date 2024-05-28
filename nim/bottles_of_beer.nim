proc pluralize(number: int = 0): string =
  if number != 1: "s" else: ""
  
when isMainModule:
  var bottlesOfBeer = 99
  for i in countdown(bottlesOfBeer, 0):
    var s = pluralize(i)
    var distribution = if i > 0: "Take one down and pass it around" else: "Go to the store, buy some more"
    var nextNumber = if i > 0: i - 1 else: i
    echo $i & " bottle" & $s & " of beer on the wall, " & $i & " bottle" & $s & " of beer."
    echo $distribution & ", " & $nextNumber & " bottle" & pluralize(nextNumber) & " of beer on the wall."
