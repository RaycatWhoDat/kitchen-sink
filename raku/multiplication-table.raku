printf('%3s ' x 14 ~ "\n", ("", |^13));
for (^13 X ^13).kv -> $index, @numbers {
    my $format = Q:c '%3s {"\n" if ($index + 1) %% 13}';
    printf($format, @numbers[0]) if $index %% 13; 
    printf($format, [*] @numbers);
}
