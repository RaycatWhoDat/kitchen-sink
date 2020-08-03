use v6;

my @names = <Syd Sabrina Veronica Sean Karan Ray>;
my @combinations = @names.combinations: 2;
my @pairs;

loop {
    @pairs = @combinations.pick: 3;
    last if @names (<=) @pairs[*;*];
};

say "How about...";
say "$_[0] and $_[1]" for @pairs;

