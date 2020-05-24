use v6;
use MONKEY-SEE-NO-EVAL;

sub test() {
    BEGIN {
        if 0.5 < rand {
            EVAL "sub whatever() { }; 1" or die $!;
        } else {
            EVAL "sub whatever { }; 1" or die $!;
        }
    }
    whatever  / 25 ; # / ; die "this dies!";
}

sub MAIN() {
    test();
}

# Local Variables:
# compile-command: "raku test-script.raku"
# End:
