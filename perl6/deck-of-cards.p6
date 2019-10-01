use v6;

enum Suit <Hearts Spades Diamonds Clubs>;

class Card {
    has Suit $.suit is required('A Card must have a suit.');
    has Int $.value is required('A Card must have a value.');

    method gist() {
        my %values = <1 A 11 J 12 Q 13 K>;
        my @suits = <♥ ♠ ♦ ♣>;
        (%values{$.value + 1} || $.value + 1) ~ @suits[$.suit.value];
    }
}

class Deck {
    has @.cards of Card is required is rw;

    submethod BUILD() {
        @!cards = gather {
            for ^52 { take Card.new(suit => Suit($_ % 4), value => $_ % 13); }
        };
    }
}

sub MAIN() {
    my $deck = Deck.new();
    for $deck.cards { .say; }
}

# Local Variables:
# compile-command: "perl6 ./deck-of-cards.p6"
# End:
