grammar BrainFuck::Grammar {
    rule TOP { ^^ <expression>+ $$ }
    
    proto rule expression { * }
    rule expression:sym<increment> { "+" }
    rule expression:sym<decrement> { "-" }
    rule expression:sym<next-cell> { ">" }
    rule expression:sym<previous-cell> { "<" }
    rule expression:sym<print-ascii-value> { "." }
    rule expression:sym<read-char-to-cell> { "," }
    rule expression:sym<if-zero-skip> { "[" }
    rule expression:sym<if-zero-loop> { "]" }
}

class BrainFuck::Actions {
    my byte @cells[5000] = 0 xx 5000;
    my $data-pointer = 0;
    
    method expression:sym<increment>($/) { @cells[$data-pointer] += 1;  }
    method expression:sym<decrement>($/) { @cells[$data-pointer] -= 1;  }
    method expression:sym<next-cell>($/) { $data-pointer += 1; }
    method expression:sym<previous-cell>($/) { $data-pointer -= 1; }
    method expression:sym<print-ascii-value>($/) { say @cells[$data-pointer].chr; }
    method expression:sym<read-char-to-cell>($/) { @cells[$data-pointer] = $*IN.getc.ord; }
    # TODO: Finish these two.
    method expression:sym<if-zero-skip>($/) {
        return if @cells[$data-pointer] == 0;
    }

    method expression:sym<if-zero-loop>($/) {
        return unless @cells[$data-pointer] == 0;
    }
}

BrainFuck::Grammar.parse("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.", actions => BrainFuck::Actions);

BrainFuck::Grammar.parse("++++++ [ > ++++++++++ < - ] > +++++ .", actions => BrainFuck::Actions);
