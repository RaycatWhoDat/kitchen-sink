enum Hand <ROCK PAPER SCISSORS>;
my %chart = ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER;

my Str $choice;

sub get-input(Str $message, @accepted-answers --> Str) {
    my $input;
    loop {
        $input = prompt($message).trim;
        last if $input ~~ one @accepted-answers;
    }
    $input;
}

my $player-choice = Hand.^enum_from_value(get-input("Choose one: 1 - Rock, 2 - Paper, 3 - Scissors | ", <1 2 3>) - 1);
my $cpu-choice = Hand.pick;

say "Player throws {$player-choice}.";
say "Computer throws {$cpu-choice}.";

if (%chart{$cpu-choice} eqv $player-choice) {
    say "You lose.";
} elsif (%chart{$player-choice} eqv $cpu-choice) {
    say "You win.";
} else {
    say "Draw.";
}

