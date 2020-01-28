use v6;

sub pigIt(Str $sentence) {
    return join " ", gather for $sentence.split(" ") -> $word {
        # Doesn't work.
        take $word.substr(1) ~ $word.substr(0, 1) ~ ($word ~~ /([a..z] || [A..Z])+/ ?? "ay" !! "");
    }
}

say pigIt("Pig Latin is cool"); # igPay atinlay siay oolcay
say pigIt('Hello world !'); # elloHay orldway !


# Local Variables:
# compile-command: "perl6 pig-latin.p6"
# End:

