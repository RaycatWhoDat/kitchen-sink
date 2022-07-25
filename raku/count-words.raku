my @words = q:to/END/;
The foo the foo the
defenestration the
END
# or $*IN.slurp;

for @words.lc.words.sort.Bag.kv { say "$^a $^b" }
