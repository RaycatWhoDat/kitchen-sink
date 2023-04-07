my $string;
my $character;
my $occurrences;
for "aabcccccaaa".comb {
    LAST { $string ~= $character ~ $occurrences }
    if $character !~~ $_ {
        ($string ~= $character ~ $occurrences) if $occurrences;
        $occurrences = 0;
        $character = $_;
    }
    $occurrences++;
}
say $string;
