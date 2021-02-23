use v6;

my @names = <Lex Sabrina Sean Karan Ray Solo>;
my @combinations = @names.combinations: 2;
my @pairs;

loop {
    @pairs = @combinations.pick: 3;
    last if @names (<=) @pairs[*;*];
};

say "How about...";
for @pairs -> ($first-pair, $second-pair) {
    when $first-pair ~~ 'Solo' { say "$second-pair goes to the Gulag" }
    when $second-pair ~~ 'Solo' { say "$first-pair goes to the Gulag" }
    default { say "$first-pair and $second-pair" }
}

# Sabrina and Sean
# Lex and Ray
# Karan goes to the Gulag

# Lex and Karan
# Sabrina goes to the Gulag
# Sean and Ray

# Lex and Sean
# Sabrina and Karan
# Ray goes to the Gulag

# Lex and Sabrina
# Ray and Karan
# Sean goes to the Gulag
