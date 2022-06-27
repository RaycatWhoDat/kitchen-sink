my @numbers = [];
loop {
    my $number = prompt "Enter a number: ";
    last if $number ~~ / 'done' /;
    redo if $number !~~ Allomorph;
    @numbers.push($number);
    say "OK";
}

my @stats = ([+] @numbers) / @numbers.elems, @numbers.min, @numbers.max;
@stats.push: sqrt(([+] @numbers.map({ ($_ - @stats[0]) ** 2 })) / @numbers.elems);

say "Numbers: @numbers[]";
say "The average mean is @stats[0].";
say "The minimum is @stats[1].";
say "The maximum is @stats[2].";
say "The standard deviation is @stats[3].";
