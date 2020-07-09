use v6;

sub MAIN(Str $file-path) {
    my @results;
    my %count;

    for $file-path.IO.lines {
        my ($username) = .split(" ", :skip-empty);
        @results.push($username);
        %count{$username}++
    }

    .say for @results.grep({ %count{$_} > 1 }).unique
}
