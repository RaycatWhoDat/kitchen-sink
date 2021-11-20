# TODO: Parsing over multiple lines doesn't work?

grammar REBOL {
    rule TOP { ^^ <any-type>* %% <.ws> $$ }

    token any-type {
        | <block>
        | <paren>
        | <lit-word>
        | <set-word>
        | <datatype>
        | <word>
    }
    
    token block { '[' ~ ']' <any-type>* %% <.ws> }
    token paren { '(' ~ ')' <any-type>* %% <.ws> }
    
    token lit-word { ':' <word> }
    token set-word { <word> ':' }
    
    token datatype {
        | <operator>
        | <tuple>
        | <pair>
        | <number>
        | <string>
    }
    
    token operator {
        | '%'
        | '*'
        | '**'
        | '+'
        | '-'
        | '/'
        | '//'
        | '<'
        | '<<'
        | '<='
        | '<>'
        | '='
        | '=='
        | '=?'
        | '>'
        | '>='
        | '>>'
        | '>>>'
        | 'and'
        | 'is'
        | 'or'
        | 'xor'
    }

    token tuple { <integer>+ %% '.' <integer> }
    token pair { <number> 'x' <number> }
    token number { <percent> | <float> | <integer> }
    token percent { [<float> | <integer>]+ '%' }
    token float { <integer> '.' <integer> }
    token integer { \d+ }
    token string { '"' ~ '"' <char>* }
    token char { <[a..z A..Z 0..9 \-!?@#$%^&*+/,:\ \._]> }

    token word { <[a..z A..Z 0..9 \-!?@#$%^&*+/]>+ }
}

sub parse-rebol-string(Str $program) { REBOL.parse($program); }
sub parse-rebol-file(Str $filename) { REBOL.parsefile($filename); }

DOC CHECK {
    use Test;
    
    parse-rebol-string('add 1 + 2').&isnt(Nil);
    parse-rebol-string('add-two: function [num1 num2] [num1 + num2]').&isnt(Nil);
    parse-rebol-string('23.14.114').&isnt(Nil);
    parse-rebol-string('23.14.214.32').&isnt(Nil);
    parse-rebol-string('203x134').&isnt(Nil);
    parse-rebol-string('20.3x13.4').&isnt(Nil);
    parse-rebol-file('../red/filter.red').&isnt(Nil);
    parse-rebol-file('../red/get-files-v2.red').&isnt(Nil);

    done-testing;
}


