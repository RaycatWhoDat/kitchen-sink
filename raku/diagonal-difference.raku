use v6;

sub diagonal-difference(@input) {
    my ($size, @values) = @input.join(' ').split(' ');
    my @first-diagonal = (0, $size + 1, $size * 2 + 2  ... * >= $size ** 2 - 1)[^$size];
    my @second-diagonal = ($size - 1, $size + ($size - 1), $size * 2 + ($size - 2)  ... * >= $size ** 2 - $size)[^$size];
    abs([+] @values[@first-diagonal] - [+] @values[@second-diagonal]);
}

DOC CHECK {
    use Test;

    subtest "Test case 1" => {
        my @input = ("3", "11 2 4", "4 5 6", "10 8 -12");
        diagonal-difference(@input).&is(15);
    }

    subtest "Sample test cases" => {
        my @input = "data/input00.txt".IO.lines;
        my (Int(Str) $output) = "data/output00.txt".IO.lines;
        diagonal-difference(@input).&is($output);
    }
}
