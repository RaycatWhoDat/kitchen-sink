sub int-to-bin(Int $number --> Int) { $number.base(2).comb(/1/).elems }

DOC CHECK {
    use Test;

    int-to-bin(1234).&is(5);

    done-testing;
}
