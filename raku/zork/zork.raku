use lib 'lib';
use GameState;

my $game = GameState.new;
loop { $game.handle-commands; }
