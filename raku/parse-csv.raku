use v6;

grammar CSVParser {
    rule TOP {
        '{'
        <valueRow>+ %% \,
        '}'
    }

    token headerRow {
        '{' | '}' \s*
    }
    token valueRow {
        '"' <key> '"' ':' \s* '"' <value> '"'
    }
    token key {
        <-["]>*
    }
    token value {
        <-["]>*
    }
}

my $fileLocation = "tag-glossary.json";
my $parsed = CSVParser.parsefile($fileLocation);
my $destination = "tag-glossary-formatted.json";

spurt $destination, '{', :append;
for $parsed<valueRow> -> $valueRow {
    my $line = "  \"" ~ $valueRow<key>.trim ~ "\": \"" ~ $valueRow<value>.trim ~ "\",\n";
    spurt $destination, $line, :append;
}
spurt $destination, '}', :append;
