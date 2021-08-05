sub g(Str $suffix = '') {
    state Int $count = 0;
    if $suffix.chars > 0 {
        LEAVE { $count = 0; }
        'g' ~ 'o' x ($count ?? $count !! 1) ~ $suffix;
    } else {
        $count++;
        &g;
    }
}

say g()()()()()()()()()()()()()()('al');
say g()()()()()()()('al');
say g()('al');
say g('al');
