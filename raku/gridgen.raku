subset LineOrBreak of Str where * ~~ "line"|"break";

sub draw-row(Int $columns = 1, LineOrBreak $lob = "line") {
    my @delimiters = $lob ~~ "break" ?? <+ -> !! ("|", " ");
    for ^$columns { print @delimiters[0], @delimiters[1] x 4 };
    say @delimiters[0];
}

sub MAIN(Int $rows = 4) {
    for ^$rows {
        draw-row($rows, "break");
        draw-row($rows) for ^$rows;
    }
    draw-row($rows, "break");
}
