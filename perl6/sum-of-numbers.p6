my @numbers = (1..25);

my $forSum = 0;
my $whileSum = 0;
my $recurseSum = 0;

sub addTogether(@numbers) {
    $recurseSum += @numbers.head();
    return @numbers.tail(*-1) ~~ () ?? $recurseSum !! addTogether(@numbers.tail(*-1));
}

sub MAIN() {
    for @numbers { $forSum += $_ }
    while $whileSum < $forSum { $whileSum = [+] @numbers }
    ($forSum, $whileSum, addTogether(@numbers)).say;
    say (<a b c> Z (1, 2, 3)).flat;
    say (1, 1, * + * ... *)[^100];
}

# Local Variables:
# compile-command: "perl6 ./sum-of-numbers.p6"
# End:
