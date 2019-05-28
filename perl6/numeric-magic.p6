sub MAIN() {
    say "Magic with Numbers!";
    say (1..Inf).map(* ** 2)[25..100];
    say "This took " ~ (time - CHECK time) ~ " seconds to finish."
}

# Local Variables:
# compile-command: "perl6 numeric-magic.p6"
# End:
