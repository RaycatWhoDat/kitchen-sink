for "data/songs.txt".IO.lines {
    my ($match) = m:g/ (.+) ' - ' (.+) ' - ' (.+) $ /;
    my ($songTitle, $artistName, $youtubeUrl) = $match.map({ .Str });
    say "Artist: $artistName\nTrack Name: $songTitle\nYouTube URL: $youtubeUrl\n";
}
