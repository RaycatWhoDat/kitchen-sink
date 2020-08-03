use v6;

sub MAIN() {
    my @numbers = 'formatted_numbers.txt'.IO.lines;
    my @text = 'formatted_text.txt'.IO.lines;
    my @types = 'formatted_types.txt'.IO.lines;

    my $fileHandle = open 'final_conversion.csv', :a;
    
    for @numbers Z @text Z @types -> [$number, $text, $type] {
        $fileHandle.sprintf("%s|%s|%s", $number, $text, $type);
    }

    $fileHandle.close;
}

