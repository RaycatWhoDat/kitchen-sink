use Grammar::Tracer;

class User {
    has $.firstName;
    has $.lastName;
    has $.emailAddress;
    has $.birthdate;
}

grammar CSVRecord {
    rule TOP { ^^ <field> ** 4 %% ',' $$ }
    token field { <-[\,]>+ }
}

my $matches = CSVRecord.parse($_) for '../d/MOCK_DATA.csv'.IO.lines;

say $matches;
