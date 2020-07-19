use v6;

sub encode(Int $_) { .comb.map({ "-----.....----".substr($_..$_ + 4) }).join }
sub decode(Str $_) { .comb(5, 5).map({ "-----.....----".index($_) }).join.Int }

sub MAIN() {
    encode(1203).say; # => ----.---..-------...
    decode("-----.....-----.....-----").say; # => 5050
}
