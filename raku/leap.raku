my %test-cases = 1997 => False, 1900 => False, 2000 => True, 2024 => True;

sub is-leap-year(Int $year) returns Bool {
    return ($year %% 100 && $year %% 400) || ($year !%% 100 && $year %% 4); 
}

for %test-cases.kv -> $year, $result {
    say "$year should be $result. It is " ~ is-leap-year(+$year) ~ ".";
}
