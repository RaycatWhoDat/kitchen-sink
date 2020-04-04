use v6;

sub MAIN() {
    my $listing = run 'ls', '-a', '..', :out;
    for $listing.out.lines -> $line { say $line; }
    $listing.out.close();
}

# Local Variables:
# compile-command: "perl6 test-script.p6"
# End:
