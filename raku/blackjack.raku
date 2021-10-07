role BlackjackValue { has $.value }
class BlackjackHand {
    has @.cards;
    has $.total;

    submethod TWEAK { self.hit; }
    
    method status {
        say @!cards;
        say "Total value: { $!total }";
    }
    
    method hit($deck = Nil) {
        @!cards.push: $deck.hit if $deck;
        $!total = [+] @!cards.map(*.value);
    }
}

class BlackjackDeck {
    constant starting-hand-size = 2;
    constant number-of-players = 1;
    
    has @.cards;

    submethod TWEAK { self.reset; }
    
    method reset {
        @!cards = gather for |(2..10), |<J Q K A> X <♥ ♠ ♦ ♣> -> ($value, $suit) {
            given $value {
                when 2..9 { take "$value$suit" but BlackjackValue($_) };
                when 10|'J'|'Q'|'K' { take "$value$suit" but BlackjackValue(10) };
                when 'A' { take "$value$suit" but BlackjackValue(1|11) };
            };
        }
    }

    method deal {
        @!cards.pick(starting-hand-size * (number-of-players + 1)).rotor(starting-hand-size);
    }

    method hit { @!cards.pick; }
}

my $deck = BlackjackDeck.new;
my $player-hand = BlackjackHand.new(cards => $deck.deal.first);
$player-hand.status;

loop {
    $player-hand.hit($deck);
    $player-hand.status;
    last if $player-hand.total > 21 && not $player-hand.total <= 21;
}

say "You've busted!";
