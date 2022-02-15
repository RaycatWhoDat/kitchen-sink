my @possible-words = <apple grape onion honey mango piece peace tower spoon knife plate>;
my $chosen-word = @possible-words.pick;
my @guesses;

constant $ansi_reset = "\x1B[0m";
constant $ansi_green = "\x1B[30;1m\x1B[42m";
constant $ansi_yellow = "\x1B[30;1m\x1B[43m";
constant $ansi_red = "\x1B[31m\x1B[40m";

put "Wordle!";
loop {
    my $guess = prompt "Please guess a 5-letter word: ";
    if $guess !~~ / ^^ \w ** 5 $$ / {
        put "Not a 5-letter word.";
        redo;
    }

    @guesses.append: $guess;
    $guess .= comb.cache;
    my @valid-letters = $chosen-word.comb.cache;
    print "Guess #{@guesses.elems}: ";

    for $guess.kv -> $index, $letter {
        my $color;
        if @valid-letters[$index] eqv $letter {
            $color = $ansi_green;
        } elsif $letter (elem) @valid-letters {
            my $found-index = $chosen-word.index($letter);
            @valid-letters = @valid-letters[(^5).grep(* !== $found-index)];
            $color = $ansi_yellow;
        } else {
            $color = $ansi_red;
        }

        print "$color$letter$ansi_reset";
    }
    
    put "";

    if $guess.join eqv $chosen-word {
        put "Congratulations! You've solved it!";
        last;
    } elsif @guesses.elems >= 6 {
        put "Sorry! You didn't guess the word.";
        last;
    }
}

