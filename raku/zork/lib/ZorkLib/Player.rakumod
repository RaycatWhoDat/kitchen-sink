use ZorkLib::Room;

unit class Player is export;

has Str $.name is rw;
has Int $.level is rw = 1;
has Room $.current-room is rw;

submethod TWEAK {
    $!name = prompt "What is your name? ";
}

method status {
    say "You are $!name, a Level $!level adventurer.";
    say "You are currently in {$!current-room.name}.";
    say $!current-room.description if $!current-room.description;
}
