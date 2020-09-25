use v6;

my $file = "24-hour-clock.raku".IO.slurp;
my $match = $file ~~ / "return %formattedTime;" /;

say $match.replace-with: q:to/END/;
say %formattedTime;
return %formattedTime;
END
