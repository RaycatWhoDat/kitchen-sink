sub MAIN(Int $bottlesOfBeer = 99) {
    sub pluralize(Int $number = 0) { $number > 1 ?? "s" !! '' }
    loop (my $remainingBottles = $bottlesOfBeer; $remainingBottles > 0; $remainingBottles--) {
        my $s = pluralize($remainingBottles);
        my $distribution = $remainingBottles > 1 ?? "Take one down and pass it around" !! "Go to the store, buy some more";
        my $nextNumber = $remainingBottles > 1 ?? $remainingBottles - 1 !! $bottlesOfBeer;
        say "$remainingBottles bottle$s of beer on the wall, $remainingBottles bottle$s of beer.";
        $s = pluralize($nextNumber);
        say "$distribution, $nextNumber bottle$s of beer on the wall.";
    }
}

# Local Variables:
# compile-command: "perl6 ./bottles-of-beer.p6"
# End:
