role BlackjackValue { has $.value }
class BlackjackHand {
    has @.cards;
    has $.total;

    method status {
        say @!cards;
        say "Total value: { $!total }";
    }
    
    method hit(@deck = ()) {
        @!cards.push: @deck.pick if @deck;
        $!total = [+] @!cards.map(*.value);
    }
    
    submethod TWEAK { self.hit; }
}

my @deck = gather for |(2..10), |<J Q K A> X <♥ ♠ ♦ ♣> -> ($value, $suit) {
    given $value {
        when 2..9 { take "$value$suit" but BlackjackValue($_) };
        when 10|'J'|'Q'|'K' { take "$value$suit" but BlackjackValue(10) };
        when 'A' { take "$value$suit" but BlackjackValue(1|11) };
    };
}

constant starting-hand-size = 2;
constant number-of-players = 1;
my @hands = @deck.pick(starting-hand-size * (number-of-players + 1));
my $player-hand = BlackjackHand.new(cards => @hands.rotor(starting-hand-size).first);
$player-hand.status;

loop {
    $player-hand.hit(@deck);
    $player-hand.status;
    last if $player-hand.total > 21 && not $player-hand.total <= 21;
}

say "You've busted!";
