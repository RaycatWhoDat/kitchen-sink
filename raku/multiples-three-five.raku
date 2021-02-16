use v6;

sub sum-multiples(@input) { [+] @input.grep(* %% (3|5)) }

DOC CHECK {
    use Test;

    subtest "Test case" => {
        sum-multiples(^10).&is(23);
    }

    subtest "Answer" => {
        sum-multiples(^1000).&is(23);
    }
}
