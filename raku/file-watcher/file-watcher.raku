my $file = "./test-file.txt".IO;

say "{$file.slurp.words.elems} words";

react whenever $file.watch.unique(:as(*.path), :expires(1)) {
    say "{$file.slurp.words.elems} words";
}
