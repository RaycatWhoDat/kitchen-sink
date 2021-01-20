use v6;

unit sub MAIN(Int $end-number where * > 0);

say [+] (1, 1, * + * ... *).grep(* !%% 2)[^$end-number];

