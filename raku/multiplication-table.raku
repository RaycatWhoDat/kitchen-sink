for (^13 X ^13).kv -> $index, @numbers {
    printf("%3s ", [*] @numbers);
    print "\n" if ($index + 1) %% 13;
}
