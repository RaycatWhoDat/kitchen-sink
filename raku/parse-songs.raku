for "data/songs.txt".IO.lines {
    my ($match) = m:g/ (.+) ' - ' (.+) /;
    my ($songTitle, $youtubeUrl) = $match.map({ .Str });
    say "Song Title: $songTitle";
    say "YouTube URL: $youtubeUrl";
    say "";
}
