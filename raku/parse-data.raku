grammar CSVRecord {
    rule TOP { ^^ <field> ** 4 %% ',' $$ }
    token field { <-[\,]>+ }
}

for '../d/MOCK_DATA.csv'.IO.lines {
    my ($firstName, $lastName, $emailAddress, $birthdate) = CSVRecord.parse($_)<field>;
    say "$firstName, $lastName, $emailAddress, $birthdate"
}
