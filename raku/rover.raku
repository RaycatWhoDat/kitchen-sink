use v6;

enum Direction (N => [0, -1], E => [1, 0], S => [0, 1], W => [-1, 0]);

subset GridConfig of Str where * ~~ / ^ \d+ <ws> \d+ $ /;
subset StartingPosition of Str where * ~~ / ^ \d+ <ws> \d+ <ws> <[NESW]> $ /;
subset Instructions of Str where * ~~ / ^ <[MLR]>+ $ /;

class Rover {
    has $!grid-height = 0;
    has $!grid-width = 0;
    has $!x = 0;
    has $!y = 0;
    has $!direction;

    method getCurrentPosition {
        my $formatted-direction = $!direction.key;
        say "Currently at $!x $!y facing $formatted-direction...";
        qqw{$!x $!y $formatted-direction}
    }
    
    method setGrid(GridConfig $grid-config) {
        my ($height, $width) = $grid-config.split: " ";
        say "Setting grid dimensions to width $width and height $height...";
        $!grid-height = $height.Int;
        $!grid-width = $width.Int;
    }

    method setStartingPosition(StartingPosition $starting-position) {
        my ($starting-x, $starting-y, $starting-direction) = $starting-position.split: " ";
        say "Setting starting position to $starting-x $starting-y facing $starting-direction...";
        $!x = $starting-x.Int;
        $!y = $starting-y.Int;
        $!direction = Direction::{$starting-direction};
    }
    
    method parseInstructions(Instructions $instructions) {
        for $instructions.comb {
            when "M" {
                say "Moving forward...";
                my ($x-delta, $y-delta) = $!direction.value;
                $!x += $x-delta if 0 <= ($!x + $x-delta) <= $!grid-width;
                $!y += $y-delta if 0 <= ($!y + $y-delta) <= $!grid-height;
            }
            
            when "L" {
                say "Turning left...";
                $!direction = $!direction ~~ N ?? W !! $!direction.pred;
            }
            
            when "R" {
                say "Turning right...";
                $!direction = $!direction ~~ W ?? N !! $!direction.succ;
            }
        }
    }
}

DOC CHECK {
    use Test;

    subtest "Test case 1" => {
        my $grid-config = "5 5";
        my $starting-position = "1 2 N";
        my $instructions = "LMLMLMLMM";
        my $rover = Rover.new();

        given $rover {
            .setGrid($grid-config);                  
            .setStartingPosition($starting-position);
            .parseInstructions($instructions);       
            .getCurrentPosition.&is(<1 1 N>);
        }
    }
    
    subtest "Test case 2" => {
        my $grid-config = "5 5";
        my $starting-position = "3 3 N";
        my $instructions = "MMRMMRMRRM";
        my $rover = Rover.new();
        
        given $rover {
            .setGrid($grid-config);                  
            .setStartingPosition($starting-position);
            .parseInstructions($instructions);       
            .getCurrentPosition.&is(<5 1 N>);
        }
    }
}
