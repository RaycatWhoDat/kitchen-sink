use v6;

sub capitalize-e(Str $input) { $input.trans("e" => "E") }
sub fizzbuzz {
    gather { take ($_ %% (3 & 5) ?? "FizzBuzz" !! $_ %% 5 ?? "Buzz" !! $_ %% 3 ?? "Fizz" !! $_) for 1 .. 20 }
}

DOC CHECK {
    use Test;

    subtest "E replacement" => {
        my $input = "Perl Weekly Challenge";
        capitalize-e($input).&is("PErl WEEkly ChallEngE");
    }

    subtest "FizzBuzz" => {
        my $output = (1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz");
        fizzbuzz.&is($output);
    }
}
