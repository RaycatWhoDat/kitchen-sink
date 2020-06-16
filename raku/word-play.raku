sub has-no-e(Str $input) { not $input.contains('e') }
sub avoids(Str $forbidden-letters, Str $input) { not so $input.comb (&) $forbidden-letters.comb }

sub MAIN(Str $input) { say avoids("tes", $input) }
