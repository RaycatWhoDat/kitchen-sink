sub count-symmetric-characters(@words) {
    gather for @words {
        take [+] .lc.comb.kv.map({ +($^a == $^b.ord - 97) });
    }
}

DOC CHECK {
    use Test;

    my @test-case = "abode","ABc","xyzD";
    count-symmetric-characters(@test-case).&is((4, 3, 1));

    done-testing;
}
