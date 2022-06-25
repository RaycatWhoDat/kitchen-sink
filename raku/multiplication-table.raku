printf('%3s ' x 14 ~ "\n", ("", |^13));
for (^13 X ^13).kv -> $index, @numbers {
    printf('%3s ', @numbers[0]) if $index %% 13; 
    printf('%3s ', [*] @numbers);
    print("\n") if ($index + 1) %% 13;
}
