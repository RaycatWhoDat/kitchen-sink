my @values1 = (1..3).map: * => 1;
my @values2 = (4..6).map: * => 2;
my @values3 = (7..9).map: * => 3;

(@values1, @values2, @values3).flat.BagHash.pick.say;
               
