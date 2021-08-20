my @test-cases = ["the three truths", "th"], ["ababababab", "abab"];

sub count-occurrences($string, $substring) { +$string.comb: / :r $substring / }
say "$_[0]: {count-occurrences(|$_)}" for @test-cases;
