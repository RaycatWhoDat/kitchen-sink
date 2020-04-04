my @numbers = (1..25);

my $forSum = 0;
my $whileSum = 0;
my $recurseSum = 0;

my $addTogether = -> @numbers, $sum = 0 {
    @numbers.skip(1) ~~ ()
    ?? $sum + @numbers.head
    !! $addTogether(@numbers.skip(1), $sum + @numbers.head);
}

sub MAIN() {
    for @numbers { $forSum += $_ }
    while $whileSum < $forSum { $whileSum = [+] @numbers }
    $recurseSum = $addTogether(@numbers);
    say ($forSum, $whileSum, $recurseSum);
    
    say (<a b c> Z (1, 2, 3)).flat;

    say (1, 1, * + * ... *)[^100];
}

# Local Variables:
# compile-command: "perl6 ./sum-of-numbers.p6"
# End:
