my @lines = "../d/MOCK_DATA.csv".IO.lines[1..*];
for @lines {
    m/ (.+) ',' (.+) ',' (.+) ',' (.+) /;
    printf("%20s %20s %30s %10s\n", $0, $1, $2, $3);
};
