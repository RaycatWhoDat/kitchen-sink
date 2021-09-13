for "data/songs.txt".IO.lines {
    my ($match) = m:g/ (.+) ' - ' (.+) ' - ' (.+) $ /;
    my ($songTitle, $artistName, $youtubeUrl) = $match.map({ .Str });
    say "Artist: $artistName";
    say "Track Name: $songTitle";
    say "YouTube URL: $youtubeUrl\n";
}
