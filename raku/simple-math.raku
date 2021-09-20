sub prompt-for-number(Str $message = '') {
    my $number;
    loop {
        $number = try prompt $message;
        last if +$number;
        say "Please enter a valid number.";
    }
    $number;
}

my $first-number = prompt-for-number("What is the first number? ");
my $second-number = prompt-for-number("What is the second number? ");
my %operations = "+" => &infix:<+>, "-" => &infix:<->, "*" => &infix:<*>, "/" => &infix:</>;

say "$first-number $_[0] $second-number = {$_[1]($first-number, $second-number)}" for %operations.kv.rotor: 2;
