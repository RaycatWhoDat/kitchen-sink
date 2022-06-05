sub fizz-buzz($number) {
    return gather for 1..$number {
        when $_ %% (3 & 5) { take "FizzBuzz" }
        when $_ %% 5 { take "Buzz" }
        when $_ %% 3 { take "Fizz" }
        default { take $_ }
    }
}

DOC CHECK {
    use Test;

    fizz-buzz(3).&is([1,2,"Fizz"]);
    
    done-testing;
}
