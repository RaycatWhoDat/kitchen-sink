import zero_functional

var seq1 = "MOCK_DATA.csv".lines.toSeq
var seq2 = 6 .. 10
var seq3 = seq1.reversed

seq1 --> zip(seq2, seq3) --> foreach(echo it)
