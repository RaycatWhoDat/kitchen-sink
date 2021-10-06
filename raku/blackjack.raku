role BlackjackValue { has $.value }

my @deck = gather for |(2..10), |<J Q K A> X <♥ ♠ ♦ ♣> -> ($value, $suit) {
    given $value {
        when 2..9 { take "$value$suit" but BlackjackValue($_) };
        when 10|'J'|'Q'|'K' { take "$value$suit" but BlackjackValue(10) };
        when 'A' { take "$value$suit" but BlackjackValue(1|11) };
    };
}

my @hand = @deck.pick: 2;
say @hand;
say "Total value: $_" for [+] @hand.map(*.value);
