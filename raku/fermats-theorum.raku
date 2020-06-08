sub check-fermat(Int $a, Int $b, Int $c, Int $n where { $n > 2 }) {
    $a ** $n + $b ** $n == $c ** $n
}

sub MAIN() {
    my Int $a = prompt "Enter a value for A: ";
    my Int $b = prompt "Enter a value for B: ";
    my Int $c = prompt "Enter a value for C: ";
    my Int $n = prompt "Enter a value for N: ";

    say check-fermat($a, $b, $c, $n)
    ?? "Holy smokes, Fermat was wrong!"
    !! "No, that doesn't work."
}
