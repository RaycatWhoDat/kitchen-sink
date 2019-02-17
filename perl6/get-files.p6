# Let's reimplement 'get-files.lua' in Perl 6.

my $file_level = 0;
my $max_indent_level = 4;
my @ignored_paths = ".", "..", ".git", "node_modules";

sub generate_indent($file_level) {
    my $indentation = "";
    for (0..($max_indent_level * ($file_level - 1))) {
	$indentation = $indentation ~ ' ';
    }
    return $indentation;
}

sub list_files($directory = './') {
    my @files = dir $directory;
    $file_level += 1;
    for (0..@files.end) {
        my $current_filename = @files[$_].basename;
        my $should_ignore = False;
        
        for @ignored_paths {
            $should_ignore = $current_filename ~~ $_;
            last if $should_ignore;
        }

        next if $should_ignore;
        
	say generate_indent($file_level) ~ @files[$_].basename;
	list_files(@files[$_]) if @files[$_].d;
    }
    $file_level -= 1;
}

list_files();
