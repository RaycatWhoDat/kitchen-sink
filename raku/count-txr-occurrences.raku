say "Counting the number of occurrences of TXR...";
say "../awk/test-text.txt".IO.slurp.comb(/ TXR /).elems;
