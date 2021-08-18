Red []

#include %extra.red

print rejoin ["Small Pos to Large Pos" ":" space 1 .. 10]
print rejoin ["Large Pos to Small Pos" ":" space 10 .. 1]
print rejoin ["Small Neg to Large Neg" ":" space -5 .. -1]
print rejoin ["Large Neg to Small Neg" ":" space -1 .. -5]
print rejoin ["Small Neg to Large Pos" ":" space -5 .. 5]
print rejoin ["Large Pos to Small Neg" ":" space 5 .. -5]
print rejoin ["Unspecified Large Pos" ":" space R 10]
print rejoin ["Same Ends" ":" space 1 .. 1]
