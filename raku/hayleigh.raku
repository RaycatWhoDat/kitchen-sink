sub thingamajig(Int $_ where * >= 0) {
    given .polymod(26).cache { "{'a' x .[1]}{('a'..'z')[.[0]]}" }
}

DOC CHECK {
    use Test;

    thingamajig(0).&is('a');
    thingamajig(1).&is('b');

    thingamajig(26).&is('aa');
    thingamajig(27).&is('ab');
    
    thingamajig(52).&is('aaa');
    thingamajig(53).&is('aab');
    
    done-testing;
}
