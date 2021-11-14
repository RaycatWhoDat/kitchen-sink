grammar REBOL {
    rule TOP { ^^ <expression>* $$ }

    token block { '[' ~ ']' <expression>* }
    token paren { '(' ~ ')' <expression>* }
    
    token expression {
        [<block> | <paren> | <lit-word> | <set-word> | <word>]+ %% <.ws>
    }
    token lit-word { ':' <word> }
    token set-word { <word> ':' }

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

    token datatype {
        | <operator>
        | <tuple>
        | <pair>
        | <number>
        | <string>
    }
    token tuple { <integer>+ %% '.' <integer> }
    token pair { <number> 'x' <number> }
    token number { <percent> | <float> | <integer> }
    token percent { [<float> | <integer>]+ '%' }
    token float { <integer>+ '.' <integer>+ }
    token integer { \d+ }
    token string { '"' ~ '"' <char>* }
    token char { <[a..z A..Z 0..9 \-!?@#$%^&*+/,:\ ]> }
    
    token word {
        | <datatype>
        | <identifier>
    }

    token identifier { <[a..z A..Z 0..9 \-!?@#$%^&*+/]>+ }
}

sub parse-rebol-string(Str $program) {
    my $matches = REBOL.parse($program);
    .say for $matches<expression>;
}

sub parse-rebol-file(Str $filename) {
    my $matches = REBOL.parsefile($filename);
    .say for $matches<expression>;
}

DOC CHECK {
    use Test;

    parse-rebol-string('add 1 + 2');
    parse-rebol-string('add-two: function [num1 num2] [num1 + num2]');
    parse-rebol-string('23.14.114');
    parse-rebol-string('23.14.214.32');
    parse-rebol-string('203x134');
    parse-rebol-string('20.3x13.4');
    parse-rebol-file('../red/filter.red');
    
    done-testing;
}


