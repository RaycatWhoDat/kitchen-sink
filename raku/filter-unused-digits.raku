sub get-unused-digits(@digits) { ((^10).join.comb (^) @digits.join.comb).keys.sort.join };

DOC CHECK {
    use Test;

    my @test-case1 = 12, 34, 56, 78;
    my @test-case2 = 2015, 8, 26;
    
    get-unused-digits(@test-case1).&is("09");
    get-unused-digits(@test-case2).&is("3479");
    
    done-testing;
}
