my constant $file = "../d/MOCK_DATA.csv".IO.lines.cache;
my @column-names = $file.head.split(',');
my @matches = gather for $file[1..*] {
    take m:g/ (.+) ** {@column-names.elems} % ','/;
};
for @matches {
    say "$_[0]: $_[1]" for @column-names Z .head.flat;
    say "";
}
