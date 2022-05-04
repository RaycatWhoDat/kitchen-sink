sub sum-bitwise(@numbers) { ([~&] $_ for @numbers.combinations(2)).sum; }

DOC CHECK {
    use Test;

    sum-bitwise((1, 2, 3)).&is(3);
    sum-bitwise((2, 3, 4)).&is(2);
    
    done-testing;
}

