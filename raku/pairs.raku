my @names = <Solo Sabrina Veronica Sean Karan Ray>;
my @combinations = @names.combinations: 2;
my @pairs;

loop {
    @pairs = @combinations.pick: 3;
    last if @pairs[*;*].sort eqv @names.sort;
}

say "How about...";
for @pairs -> ($firstPerson, $secondPerson) {
    say "$secondPerson works solo" if $firstPerson eqv "Solo";
    say "$firstPerson works solo" if $secondPerson eqv "Solo";
    say "$firstPerson and $secondPerson" if not $firstPerson | $secondPerson eqv "Solo";
}
