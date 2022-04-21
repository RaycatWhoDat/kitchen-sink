my @alphabet = flat(("a".."z").eager, ("A".."Z").eager);
my @key = "XZNLWEBGJHQDYVTKFUOMPCIASRxznlwebgjhqdyvtkfuompciasr".comb;

my Str $secret-message = prompt "Enter your secret message: ";
my Str $encrypted-message = $secret-message.trans: @alphabet => @key;

say "Encrypted message: ", $encrypted-message;
say "Decrypted message: ", $encrypted-message.trans: @key => @alphabet;
