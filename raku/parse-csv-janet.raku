grammar CSVRecord {
    rule TOP { [([<quoted-value> | <unquoted-value>]) ',' ?]+ }
    token quoted-value { '"' [<unquoted-value> | ',']+ '"'}
    token unquoted-value { <[\w \s ! @ # $ % ^ & * ( ) . /]>+ }
}

for "./MOCK_DATA.csv".IO.lines[1..*] {
    CSVRecord.parse($_);
    say "First Name: $0[0]";
    say "Last Name: $0[1]";
    say "Email: $0[2]";
    say "Date of Birth: $0[3]\n";
}
