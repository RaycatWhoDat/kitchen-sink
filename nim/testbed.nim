import zero_functional

var seq1 = "MOCK_DATA.csv".lines
var seq2 = 6 .. 10
var seq3 = seq1.reversed

zip(seq1, seq2, seq3) --> foreach(echo it)
