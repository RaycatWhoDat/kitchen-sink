my @names = <Karan Sean Isabel Lex Ray Solo>;
say "$_[0] and $_[1]" for @names.permutations.words.rotor: 2;
