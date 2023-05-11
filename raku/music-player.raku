class Song {
    has Str $.title = "";
    has Str $.artist = "";
    has Str $.album = "";
    has Str $.genre = "";
    has Int $.length = 0;
    has Int $.number-of-plays is rw = 0;

    method gist(--> Str) {
        "{$!title} - {$!artist}"
    }
}

class SongPlayer {
    has Song @!playlist;
    has Int $!playlist-index = 0;
    has Song $!now-playing;
    has Bool $!is-playing = False;

    method play-song(Song $song) {
        $song.number-of-plays += 1;
        $!now-playing = $song;
    }

    method play() {
        self.play-song(@!playlist[$!playlist-index]) if so @!playlist;
        $!is-playing = True;
        say "Playing: {$!now-playing.gist}" 
    }
    
    method pause() {
        $!is-playing = False;
        say "Paused.";
    }
    
    method previous() {
        $!playlist-index -= 1 if $!playlist-index > 0;
        self.play();
    }
    
    method next() {
        $!playlist-index += 1 if $!playlist-index < @!playlist.elems - 1;
        self.play();
    }

    method load-playlist(*@songs) {
        @!playlist = @songs;
        $!playlist-index = 0;
    }
}

my @sample-playlist =
    Song.new(
        title => "gray",
        artist => "waterfront dining",
        album => "Morning Star Ballads",
        length => 162,
        number-of-plays => 0
    ),
    Song.new(
        title => "Black Coffee",
        artist => "Edo Lee",
        album => "Sleepwalker",
        length => 161,
        number-of-plays => 0
    ),
    Song.new(
        title => "Instagram",
        artist => "DEAN",
        album => "Instagram - Single",
        length => 256,
        number-of-plays => 0
    );

my $player = SongPlayer.new;

given $player {
    .load-playlist(@sample-playlist);
    .play();
    .next();
    .next();
    .next();
    .previous();
    .previous();
}
