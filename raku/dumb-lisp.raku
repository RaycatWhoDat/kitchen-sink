use v6;
use trace;

grammar DumbLispSyntax {
    rule TOP {
        <expression>+
    }

    rule expression {
        '(' ~ ')' <term>+
    }

    rule term {
        <builtin>? (<alnum>+ %% <ws>) <expression>?
    }

    proto token builtin { * }
    token builtin:sym<+> { <sym> }
    token builtin:sym<-> { <sym> }
    token builtin:sym<*> { <sym> }
    token builtin:sym</> { <sym> }
}

class DumbLispActions {
    method expression { ... }
    method term { ... }
    method builtin:sym<+> { ... }
    method builtin:sym<-> { ... }
    method builtin:sym<*> { ... }
    method builtin:sym</> { ... }
}

DOC CHECK {
    use Test;

    subtest "should parse" => {
        my $program = "(+ 1 (+ 2 (+ 3 4)))";
        my $test-case = "(a (b (c d)))";
        say DumbLispSyntax.parse($program);
    }
    
    subtest "should add recursively" => {
        my $program = "(+ 1 (+ 2 (+ 3 4)))";
        my $result = DumbLispSyntax.parse($program, :actions(DumbLispActions));
        $result.&is(10);
    }
}
