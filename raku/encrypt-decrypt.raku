# my @alphabet = flat(("a".."z").eager, ("A".."Z").eager);
# my @key = "XZNLWEBGJHQDYVTKFUOMPCIASRxznlwebgjhqdyvtkfuompciasr".comb;

my $key = "XZNLWEBGJHQDYVTKFUOMPCIASR";
my @translations = ['a'..'z'] => $key.comb,  ['A'..'Z'] => $key.lc.comb;

my Str $secret-message = prompt "Enter your secret message: ";
my Str $encrypted-message = $secret-message.trans: @translations;

say "Encrypted message: ", $encrypted-message;
say "Decrypted message: ", $encrypted-message.trans: @translations;
