subset PositiveNumber of Real where * > 0;
sub rescale(PositiveNumber() @numbers) {
    my ($min, $max) = @numbers.minmax.bounds;
    @numbers.map(* - $min).map(* / ($max - $min));
}

DOC CHECK {
    use Test;

    rescale(1..4).&is([0.0, 1/3, 2/3, 1.0]);
    rescale(5..10).&is([0, 0.2, 0.4, 0.6, 0.8, 1]);
    
    done-testing;
}
