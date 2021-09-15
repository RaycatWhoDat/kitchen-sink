sub pyramid(Int $number-of-subarrays) { [[1 for ^$_] for 1 .. $number-of-subarrays]; }

DOC CHECK {
    use Test;

    say "Pyramid tests";
    pyramid(0).&is([]);
    pyramid(1).&is([[1]]);
    pyramid(2).&is([[1], [1, 1]]);
    pyramid(3).&is([[1], [1, 1], [1, 1, 1]]);
    pyramid(5).&is([[1], [1, 1], [1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1, 1]]);
}

