my Int $max_indent_level = 2;
my Str @ignored_paths = <. .. .git node_modules target love test_app zef>;

sub list_files(IO() $directory, Int $file_level = 0, &callback = { .say }) {
    for $directory.dir(test => none @ignored_paths) -> $current_file {
	&callback($current_file.basename.indent($max_indent_level * $file_level));
	list_files($current_file.path, $file_level + 1) if $current_file.d;
    }
}

sub MAIN(IO() $directory = './') {
    list_files($directory);
}

# Local Variables:
# compile-command: "perl6 ./get-files.p6 .."
# End:
