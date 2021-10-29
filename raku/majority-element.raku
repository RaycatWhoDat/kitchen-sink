sub majority-elem(*@numbers --> Int) {
    given @numbers.Bag.max { .value > floor(@numbers.elems / 2) ?? .value !! Nil }
}

DOC CHECK {
    use Test;

    majority-elem([2, 1, 2]).&is(2);
    majority-elem([1, 1, 2]).&is(Nil);
    
    done-testing;
}
