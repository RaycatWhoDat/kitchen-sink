for "data/songs.txt".IO.lines {
    m:g/ (.+) <ws> '-' <ws> (.+) <ws> '-' <ws> ('https://' .+) $ /;
    say "Artist: $0[0]\nTrack Name: $0[1]\nYouTube URL: $0[2]\n";
}
