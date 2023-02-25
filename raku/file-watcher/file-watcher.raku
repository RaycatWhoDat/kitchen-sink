my $file = "./test-file.txt".IO;

say "{$file.slurp.words.elems} words";

react whenever $file.watch.unique(:as(*.path)) {
    say "{$file.slurp.words.elems} words";
}
