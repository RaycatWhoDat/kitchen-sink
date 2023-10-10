class Player {
    my $number-of-players;
    
    has Str $.name = "Player {++$number-of-players}";
    has Int $.last-roll = 1000;

    method death-roll(Int $starting-number) {
        $!last-roll = ($starting-number.rand + 1).Int;
        say "Random! {$!name} rolls a {$!last-roll} (out of {$starting-number}).";
    }
}

my ($current-player, $other-player) = Player.new, Player.new;
until $current-player.last-roll == 1 {
    $current-player.death-roll: $other-player.last-roll;
    ($current-player, $other-player) .= reverse;
}
say "Game over! {$current-player.name} wins!";
