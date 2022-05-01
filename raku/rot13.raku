subset TranslationMode of Str where * eqv "encode"|"decode";

sub rot13(Str $message, TranslationMode :$mode) {
    my $translation = ["a".."z", "A".."Z"] => ["n".."z", "a".."m", "N".."Z", "A".."M"];
    $message.trans($mode eqv "decode" ?? $translation.antipair !! $translation);
}

sub encode-rot13(Str $_) { rot13($_, :mode("encode")) };
sub decode-rot13(Str $_) { rot13($_, :mode("decode")) };

DOC CHECK {
    use Test;
    
    encode-rot13("In the elevators, the extrovert looks at the OTHER guy's shoes.").&is("Va gur ryringbef, gur rkgebireg ybbxf ng gur BGURE thl'f fubrf.");
    decode-rot13("Va gur ryringbef, gur rkgebireg ybbxf ng gur BGURE thl'f fubrf.").&is("In the elevators, the extrovert looks at the OTHER guy's shoes.");

    done-testing;
}
