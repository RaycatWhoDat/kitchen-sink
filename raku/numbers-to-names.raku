my $response;

loop {
    $response = prompt "Please enter the number of the month: ";
    last if $response ~~ 1..12;
    say "Please enter a number between 1 and 12.";
}

my @months = <January February March April May June July August September October November December>;
say "The name of the month is {@months[$response - 1]}.";
