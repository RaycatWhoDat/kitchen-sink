use strict; use warnings;
use File::Find "find";

my $max_indent_level = 2;
my %ignored_paths = map { $_ => 1 } qw(. .. .git node_modules target love test_app zef);
my $directory = '..';
$directory = shift @ARGV if $#ARGV + 1 > 0;

sub list_files {
    my $depth = $File::Find::dir =~ tr[/][];
    if (exists($ignored_paths{$_})) {
        $File::Find::prune = 1 if $File::Find::name ne $directory;
        return;
    }
    print(' ' x ($max_indent_level * $depth) . "$_\n");
}

find(\&list_files, $directory);

# Local Variables:
# compile-command: "perl ./get-files.pl .."
# End:

    
    
