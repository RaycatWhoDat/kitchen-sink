use Grammar::Tracer;

grammar TXRPatternMatching {
    rule TOP {
        ^^ (<expression>)+ %% \n $$
    }

    token expression { <directive> | <atom> }
    token directive {
        \@
        { say '1' }
        (\(|\{)
           { say '2' }
           (<-[\n{}]>+)
           { say '3' }
           (\)|\})
        { say '4' }
    }
    token atom { \@ (<-[\n(){}@,]>+) }
    token text { .+ }
}

sub MAIN() {
    my $file-location = '../txr/pivotal-export.txr';
    TXRPatternMatching.parsefile($file-location);
}
