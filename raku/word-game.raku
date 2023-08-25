constant @WORDS = <DINKY SMOKE WATER GLASS TRAIN MIGHT FIRST CANDY CHAMP WOULD CLUMP DOPEY>;

# print messages here
outer: loop {
    my @secret-word = @WORDS.pick.comb;
    my @known-letters = <- - - - ->;
    my $known-letters-count = 0;
    my $guess-count = 0;
    while ($guess-count < 5) {
        my $guess;
        loop {
            $guess = prompt "Guess a five-letter word: ";
            last if $guess ~~ / ^^ (\w ** 5 | "?") $$ /;
            say "You must guess a five-letter word. Try again.";
        }

        NEXT { $guess-count++; }

        if ($guess[0] eqv "?") {
            say "The secret word was {[~] @secret-word}.";
            last outer;
        }

        for (@secret-word Z $guess.uc.comb).kv -> $index, @letters {
            next if (@known-letters[$index] !eqv "-") or (not [eqv] @letters); 
            @known-letters[$index] = @letters[0];
        }
        say ~@known-letters;
        $known-letters-count = 5 - @known-letters.Bag<->;
        
        if ($known-letters-count == 5) {
            say "You win!";
            last outer;
        }
    }

    if ($guess-count >= 5) {
        say "You lose...";
        last outer;
    }
}
