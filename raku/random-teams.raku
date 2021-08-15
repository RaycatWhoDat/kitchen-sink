my @names = <RaycatWhoDat Lythero DickDebonair OverlordDyvone EmyFails NosferatChew DNOpls DahMuttDog>;

my @blue = @names.pick: 4;

say "Blue: $_" for @blue;
say "Gold: $_" for @names.grep: @blue.none;
