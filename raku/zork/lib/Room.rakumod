class Room is export {
    state Int $number-of-rooms = 1;

    has Str $.name;
    has Str $.description = "Room #{$number-of-rooms}";
    has %.rooms;

    submethod TWEAK {
        $number-of-rooms++;
    }

    method get-exits {
        %!rooms<NORTH EAST SOUTH WEST>:k.sort;
    }

    method get-expeditions {
        %!rooms<NORTH EAST SOUTH WEST>:!k.sort;
    }
}
