my $key = "XZNLWEBGJHQDYVTKFUOMPCIASR";
my @translations = ['a'..'z'] => $key.comb.list,  ['A'..'Z'] => $key.lc.comb.list;

my Str $secret-message = prompt "Enter your secret message: ";
my Str $encrypted-message = $secret-message.trans: @translations;

say "Encrypted message: ", $encrypted-message;
say "Decrypted message: ", $encrypted-message.trans: @translations.map({ .antipair });
