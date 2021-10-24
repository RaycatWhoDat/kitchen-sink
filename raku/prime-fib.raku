sub prime-fib(Int $number-of-numbers) {
    my @primes = [];
    for (1, 1, * + * ... *) {
        @primes.push: $_ if .is-prime;
        last unless @primes.elems < $number-of-numbers;
    }
    @primes;
}

say prime-fib(25).tail;
