my constant $TWO_SPACES = 2;
my @ignoredPaths = <. .. .git .dub node_modules build zef target>;

sub doFiles(IO(Str) $directoryPath, &callback = { .put }, $depth = 0) {
    for $directoryPath.dir.sort({ not .d, .Str }) -> $currentListing {
        next if $currentListing.basename (elem) @ignoredPaths;
        &callback(' ' x ($TWO_SPACES * $depth) ~ $currentListing.basename);
        doFiles($currentListing, &callback, $depth + 1) if $currentListing.d;
    }
}

doFiles("..");
