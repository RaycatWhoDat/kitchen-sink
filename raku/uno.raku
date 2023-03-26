enum Color <Red Yellow Green Blue>;
enum Effect <Reverse Skip DrawTwo Wild WildDrawFour>;

class Card {
    has Color $.color is rw;
    has Int $.number;
    has Effect $.effect;
    has Bool $.is-playable is rw;
}

class Hand {
    has Seq(Card) @.cards;
}

class Deck is Hand {
    has Card $.last-played-card is rw;
}

sub new-deck(--> Deck) {
    my $deck = Deck.new;
    $deck.cards = gather for Color.kv -> $color, $value {
        take Card.new(color => Color::{$color}, number => 0, effect => Nil);
        take slip Card.new(color => Color::{$color}, number => $_, effect => Nil) xx 2 for (1..9);
        take slip Card.new(color => Color::{$color}, number => Nil, effect => $_) xx 2 for Skip, DrawTwo, Reverse;
    }
    $deck.cards.push: slip Card.new(color => Nil, number => Nil, effect => Wild) xx 4;
    $deck.cards.push: slip Card.new(color => Nil, number => Nil, effect => WildDrawFour) xx 4;
    $deck.cards = |$deck.cards.shuffle xx *;
    $deck;
}

new-deck();
