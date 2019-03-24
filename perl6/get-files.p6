my $max_indent_level = 2;
my @ignored_paths = <. .. .git node_modules target love test_app zef>;

sub list_files($directory = './', $file_level = 0) {
    for dir $directory -> $current_file {
        next if $current_file.basename eq any(@ignored_paths);
	say (' ' x $max_indent_level * $file_level) ~ $current_file.basename;
	list_files($current_file, $file_level + 1) if $current_file.d;
    }
}

list_files("../..");

# Local Variables:
# compile-command: "perl6 ./get-files.p6"
# End:
