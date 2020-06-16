sub rotate-codepoint(Int $codepoint, Int $rotation-factor) {
    my $offset = $codepoint >= 'a'.ord ?? 'a'.ord !! 'A'.ord;
    ($offset..$offset+25).list.rotate($rotation-factor)[$codepoint - $offset];
}

sub rotate-word(Str $word, Int $rotation-factor) {
    $word.ords.map({ rotate-codepoint($_, $rotation-factor) }).chrs;
}

sub MAIN(Str $input, Int $rotation-factor) {
    say "'$input' rotated by $rotation-factor is: " ~ rotate-word($input, $rotation-factor);
}
