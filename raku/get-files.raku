use v6;

my $max-indent-level = 2;
my @ignored-paths = <. .. .git node_modules target love test_app zef dist _dub>;

sub list-files(IO() $directory, $file-level = 0, &callback = { .put }) {
    for $directory.dir(test => none @ignored-paths) -> $current-file {
	&callback($current-file.basename.indent($max-indent-level * $file-level));
	list-files($current-file.path, $file-level + 1) if $current-file.d;
    }
}

sub MAIN(IO() $directory = './') {
    list-files($directory);
}

# Local Variables:
# compile-command: "raku ./get-files.raku .."
# End:
