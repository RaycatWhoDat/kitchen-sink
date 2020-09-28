use v6;

grammar CSVParser {
    rule TOP {
        <headerRow>
        <valueRow>+ %% \n
    }

    token headerRow { <value>+ %% \, }
    token valueRow { <value>+ %% \, }
    token value { <-[,\n]>+ }
}

my $fileLocation = "../d/MOCK_DATA.csv";
my $parsed = CSVParser.parsefile($fileLocation);
for $parsed<valueRow> -> $valueRow {
    for $parsed<headerRow><value> Z $valueRow<value> -> ($key, $value) {
        say $key ~ ": " ~ $value;
    }
    say "";
}
