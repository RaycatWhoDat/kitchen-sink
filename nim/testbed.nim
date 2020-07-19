import zero_functional

var seq2 = 6 .. 10

zip("MOCK_DATA.csv".lines, seq2, "MOCK_DATA.csv".lines.reversed) --> foreach(echo it)
