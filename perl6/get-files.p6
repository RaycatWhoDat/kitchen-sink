my Int $max_indent_level = 2;
my Str[] @ignored_paths = <. .. .git node_modules target love test_app zef>;

sub list_files(Str $directory = './', Int $file_level = 0) {
    for dir $directory -> $current_file {
        next if $current_file.basename eq any(@ignored_paths);
	say (' ' x $max_indent_level * $file_level) ~ $current_file.basename;
	list_files($current_file.path, $file_level + 1) if $current_file.d;
    }
}

list_files('..');

# Local Variables:
# compile-command: "perl6 ./get-files.p6"
# End:
