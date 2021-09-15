sub anagrams(Str $word, *@possible-anagrams) {
    [|@possible-anagrams.grep({ .comb.Bag (==) $word.comb.Bag; })];
}

DOC CHECK {
    use Test;

    anagrams('abba', 'abbba').&is([]);
    anagrams('abba', 'abca').&is([]);
    anagrams('abba', 'baab').&is(['baab']);
    anagrams('abba', 'bbaa').&is(['bbaa']);
    anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']).&is(['aabb', 'bbaa']);
    anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']).&is(['carer', 'racer']);
    anagrams('laser', ['lazing', 'lazy', 'lacer']).&is([]);
}
