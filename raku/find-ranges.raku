sub find-ranges(*@items) {
    $_ = gather for @items.kv -> $index, $item {
        state $begin = Nil;
        my $next-item = @items[$index + 1];
        $begin = $item if not so $begin;
        next if ($next-item || 0) - $item == 1;
        take do {
            when $item - $begin > 1 { "{$begin}-{$item}" }
            when $item != $begin { "{$begin},{$item}" }
            default { "{$begin}" }
        }
        $begin = Nil;
    }

    .join(",");
}

DOC CHECK {
    use Test;

    find-ranges([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20]).&is("-6,-3-1,3-5,7-11,14,15,17-20");
    
    done-testing;
}
