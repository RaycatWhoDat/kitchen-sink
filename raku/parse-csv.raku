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

my $parsed = CSVParser.parsefile("MOCK_DATA.csv");
for $parsed<valueRow> -> $valueRow {
    for $parsed<headerRow><value> Z $valueRow<value> -> ($key, $value) {
        say $key ~ ": " ~ $value;
    }
    say "";
}


