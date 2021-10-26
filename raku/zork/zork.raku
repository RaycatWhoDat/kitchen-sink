use lib 'lib';
use ZorkLib::GameState;

my $game = GameState.new;
loop { $game.handle-commands; }
