my constant $file = "../d/MOCK_DATA.csv";
my @matches = gather {
    take $_ ~~ m:g/ (.+|".+") ** 4 %% ','/ for $file.IO.lines;
};
for @matches[1..*] {
    my ($firstName, $lastName, $email, $dob) = .head.list.flat;
    say "First Name: $firstName";
    say "Last Name: $lastName";
    say "Email: $email";
    say "Date of Birth: $dob";
    say "";
}
