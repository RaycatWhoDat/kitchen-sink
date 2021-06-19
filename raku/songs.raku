for "./data/songs.txt".IO.lines {
    my ($match) = m:g/ ^^ (.+) ' - ' (.+) $$ /;
    my ($songTitle, $youtube) = $match.list;
    say "Song Title/Artist: ", $songTitle.Str;
    say "YouTube Link: ", $youtube.Str;
    say "";
}
