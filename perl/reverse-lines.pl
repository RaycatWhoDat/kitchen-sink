use v5.012;
use strict;
use warnings;

my $fileName = 'mock-data.csv';
if (open(my $fileHandle, '<:encoding(UTF-8)', $fileName)) {
    while (my $currentRow = <$fileHandle>) {
        chomp $currentRow;
        my @words = split ',', $currentRow;
        say join ',', reverse @words;
    }
} else {
    die "Couldn't find file.";
}

# Save the name of your file.
# If you can "open" a "file handle" of "filename"...
# While "current row" = "file handle"...
# Remove the newline character at the end.
# Split the "current row" by a comma and save it.
# "Say" or write the reversed word array, joined by commas.
# If you can't "open" the "file handle"...
# Cease execution.
