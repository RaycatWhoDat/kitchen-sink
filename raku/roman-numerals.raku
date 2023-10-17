sub convert-roman-numeral(Str $roman-numeral where * ~~ / ^^ <[IVXLC]>+ $$ /) returns Int {
    my %numerals = "I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100;
    my @numerals = $roman-numeral.comb;

    [+] gather for @numerals.kv -> $index, $numeral {
        my ($current-number, $next-number) = (%numerals{$numeral}, %numerals{@numerals[$index + 1] || ""} || 0);
        take $current-number < $next-number ?? -$current-number !! $current-number;
    }
}

say convert-roman-numeral($_) for "I", "II", "III", "IV", "V", "VI", "VII", "IX", "X", "XIX";
