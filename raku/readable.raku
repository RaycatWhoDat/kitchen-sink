sub print-all-even-numbers-from($limit) { .say if $_ %% 2 for 0..$limit };
print-all-even-numbers-from(10);

sub print-is-odd-or-even($limit) { say $_ %% 2 ?? "even" !! "odd" for 0..$limit };
print-is-odd-or-even(10);
