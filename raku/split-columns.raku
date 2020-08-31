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

my $parsedCsv = CSVParser.parsefile("MOCK_DATA.csv");
for $parsedCsv<valueRow> -> $valueRow {
    for $parsedCsv<headerRow><value> Z $valueRow<value> -> ($key, $value) {
        spurt $key.subst(" ", "_", :g).lc ~ ".csv", $value ~ "\n", :append;
    }
}
