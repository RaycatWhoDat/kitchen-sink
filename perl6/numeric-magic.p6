class Card {
    has $.suit is rw;
    has $.value is rw;
    
    method get-suit {
        return $.suit;
    }
    
    method get-value {
        return $.value;
    }
}

class Deck {
    has Seq $.cards;

    method shuffle {
        $!cards = ((1..10; 'J', 'Q', 'K', 'A').flat xx 4).pairs.map({ my $suit = <H D C S>[$_.key()]; $_.value().map({ Card.new(suit => $suit, value => $_); }); }).flat.pick: 52;
    }
}

sub feed-operator-silliness() {
    # This deals with the feed operator.
    
    my @infinite-sequence = (map { $_ * 2} <== (1..*));
    say @infinite-sequence[50..100];
    say "This took " ~ (time - CHECK time) ~ " seconds to finish.\n";
} 

sub zip-infinite-sequences() {
    # This deals with two lazy infinite sequences.

    my @squared-infinite = (1..*).map(* ** 2);
    my @divided-infinite = (1..*).map(* / 2);

    say (@squared-infinite[^25] Z @divided-infinite[25..50]).flat;
    say "This took " ~ (time - CHECK time) ~ " seconds to finish.\n";
}

sub use-deck-of-cards() {
    # Let's use a deck of cards.
    
    my $deck = Deck.new();
    $deck.shuffle();
    say $deck.cards[^5];
    say "This took " ~ (time - CHECK time) ~ " seconds to finish.\n";
}

sub MAIN() {
    say "Magic with Numbers!\n";
    zip-infinite-sequences();
    feed-operator-silliness();
    use-deck-of-cards();
}

# Local Variables:
# compile-command: "perl6 numeric-magic.p6"
# End:
