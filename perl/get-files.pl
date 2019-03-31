# Let's just guess at stuff until it works.

use strict;
use warnings;

use File::Find;

my $max_indent_level = 2;
my %ignored_paths = map { $_ => 1 } ('.', '..', '.git', 'node_modules', 'target', 'love', 'test_app', 'zef');

sub list_files {
    return if exists($ignored_paths{$_});
    print("$File::Find::name\n");
}

find(\&list_files, ('..'))


# Local Variables:
# compile-command: "perl ./get-files.pl"
# End:

    
