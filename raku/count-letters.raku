sub MAIN(Str $_, Str $needle) {
    say "Number of times '$needle' appears: " ~ .comb(/\w/).Bag.AT-KEY($needle);
}
    
