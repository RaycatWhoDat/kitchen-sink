unit sub MAIN(Str $input);

.say for race $input.trans(' ' => '').comb.permutations.map({ .join('') }).unique;
