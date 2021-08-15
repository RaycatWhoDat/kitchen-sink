my %words = "../rust/words.txt".IO.slurp.trim.split(' ').Bag;
say "{.key}: {(* xx .value).join}" for %words;
