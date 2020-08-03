use v6;

loop {
    my $change = await ".".IO.watch;
    say "($change.path) $change.event"
}
