my $moveRegex = /:i ^ MOVE <ws> (NORTH||EAST||SOUTH||WEST) $ /;

subset Command of Str is export;
subset MoveCommand of Command where * ~~ $moveRegex is export;
subset SysCommand of Command where * ~~ /:i EXIT / is export;
