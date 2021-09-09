my $test-case1 = "This is a test";
my $test-case2 = "The quick brown fox jumps over the lazy dog.";

sub is-pangram($_) { .lc.comb.unique.grep(/<[\w]>/).elems == 26 }

say is-pangram($test-case1);
say is-pangram($test-case2);
                    
