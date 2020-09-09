use v6;

sub encode(Int $_) { .Str.comb.map({ "-----.....----".substr($_..$_ + 4) }).join }
sub decode(Str $_) { .comb(5, 5).map({ "-----.....----".index($_) }).join.Int }

encode(1203).say; # => ----.---..-------...
decode("-----.....-----.....-----").say; # => 5050
