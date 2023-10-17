my $file-path = "./test-file.txt";

say "{$file-path.IO.slurp.words.elems} words";

react whenever IO::Notification.watch-path($file-path) {
    say "{$file-path.IO.slurp.words.elems} words";
}
