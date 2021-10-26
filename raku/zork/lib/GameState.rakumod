use GameMap;
use Player;

my @directions = <NORTH EAST SOUTH WEST>;

my $exploreRegex = /:i ^ EXPLORE <ws> (@directions) $ /;
my $moveRegex = /:i ^ MOVE <ws> (@directions) $ /;
my $sysRegex = /:i ^ EXIT $ /;

my $commandRegex = $moveRegex | $sysRegex | $exploreRegex;

subset MoveCommand of Str where * ~~ $moveRegex;
subset ExploreCommand of Str where * ~~ $exploreRegex;
subset SysCommand of Str where * ~~ $sysRegex;

subset Command of Str where * ~~ $commandRegex;

class GameState is export {
    has GameMap $.map;
    has Player $.player;
    has Command $.last-command is rw; 

    submethod TWEAK {
        $!map = GameMap.new;
        $!player = Player.new;
        $!player.current-room = $!map.starting-room;
    }

    method handle-commands {
        $!player.status;
        my @rooms = $!player.current-room.get-exits;
        my @expeditions = [~] ($!player.current-room.get-expeditions (-) @rooms);
        say "You may MOVE {@rooms.join('/')}." if @rooms.elems > 0;
        say "You may EXPLORE {@expeditions.words.join('/')}." if @expeditions.elems > 0;

        my Command $next-command;
        loop {
            $next-command = prompt "What is your command? ";
            last if $next-command ~~ $commandRegex;
            NEXT { say "That is an invalid command."; }
        }

        $!last-command = $next-command;
        
        given $!last-command {
            when $moveRegex {
                $!player.current-room = $!player.current-room.rooms{"$0".uc} if "$0".uc ~~ $!player.current-room.get-exits.one;
            }

            when $exploreRegex {
                $!player.current-room = $!map.generate-unexplored-room($!player.current-room, "$0".uc);
            }

            when $sysRegex {
                exit 0;
            }
        }
    }
}
