sub MAIN(Int $bottlesOfBeer = 99) {
    sub pluralize(Int $number = 0) { $number !== 1 ?? "s" !! "" }
    for $bottlesOfBeer ... 0 {
        my $s = pluralize($_);
        my $distribution = $_ > 0 ?? "Take one down and pass it around" !! "Go to the store, buy some more";
        my $nextNumber = $_ > 0 ?? $_ - 1 !! $bottlesOfBeer;
        say "$_ bottle$s of beer on the wall, $_ bottle$s of beer.";
        say "$distribution, $nextNumber bottle{pluralize($nextNumber)} of beer on the wall.";
    }
}

# Local Variables:
# compile-command: "raku ./bottles-of-beer.raku"
# End:
