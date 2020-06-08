sub MAIN {
    subset PositiveInt of Int where * > 0;
    my PositiveInt $nth = prompt "Print how many Fibonacci numbers? ";
    .say for (1, 1, * + * ... *)[^$nth];
}
