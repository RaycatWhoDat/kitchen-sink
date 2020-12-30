use v6;

#| These must be integers.
unit sub MAIN(*@numbers where { .all ~~ Int });

sub fizzbuzz($number) {
    return "FizzBuzz" if $number %% 15;
    return "Buzz" if $number %% 5;
    return "Fizz" if $number %% 3;
    return $number;
}

say fizzbuzz($_) for @numbers;
