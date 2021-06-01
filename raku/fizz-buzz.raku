for 1..100 {
    my $output = "";
    $output ~= "Fizz" if $_ %% 3;
    $output ~= "Buzz" if $_ %% 5;
    say $output !~~ "" ?? $output !! $_;
}
