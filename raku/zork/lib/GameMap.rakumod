use Room;

class GameMap is export {
    has Room $.starting-room;

    submethod TWEAK {
        my $seed-room = Room.new(
            name => "Ye Olde Tavern",
            description => "There's nothing here but ale."
        );

        my $test-room = Room.new(
            name => "The Other Room",
            description => "This is another room.",
            rooms => "SOUTH" => $seed-room
        );

        $seed-room.rooms = "NORTH" => $test-room;
        $!starting-room = $seed-room;
    }

    method get-opposite-direction($direction) {
        my %opposites = "NORTH" => "SOUTH",
                        "EAST" => "WEST",
                        "SOUTH" => "NORTH",
                        "WEST" => "EAST";
        
        %opposites{$direction};
    }

    method generate-unexplored-room(Room $previous-room, $direction) {
        my $name = ('a' .. 'z').pick(15).join('');
        my $opposite-direction = self.get-opposite-direction($direction);
        my $new-room = Room.new(name => $name, rooms => $opposite-direction => $previous-room);
        $previous-room.rooms{$direction} = $new-room;
    }
}
