enum Operator (Add => '+', Subtract => '-', Multiply => '*', Divide => '/');

grammar Calculator::Grammar {
    rule TOP { ^^ <number> <sub-expression> <sub-expression>* $$ }
    token sub-expression { <.ws>? <operator> <.ws>? <number> }
    token number { \d* ['.' \d+]? }
    token operator { '+' | '-' | '*' | '/' }
}

class Calculator::Actions {
    method TOP($/) {
        my $result = +$/<number>;
        for $/<sub-expression> {
            my ($operation, $value) = .made.kv;
            given $operation {
                when Add { $result += $value }
                when Subtract { $result -= $value }
                when Multiply { $result *= $value }
                when Divide { $result /= $value }
            }
        }
        make $result;
    }

    method sub-expression($/) {
        given $/<operator> {
            when Add | Subtract | Multiply | Divide { make ~$_ => +$/<number>; }
        }
    }
}

class Calculator {
    method calculate(Str $input) returns Real {
        Calculator::Grammar.parse($input, actions => Calculator::Actions).made;
    }
}

say Calculator.new.calculate('1 + 2 + 3 * 6 / 2');
