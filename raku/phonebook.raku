subset YesResponse of Str when * ~~ "y"|"Y";
subset NoResponse of Str when * ~~ "n"|"N";
subset YesOrNoResponse of Str when * ~~ YesResponse|NoResponse;

my $phone-number;

sub prompt-for-number(--> Str) {
    state $text = "your";
    LEAVE { $text = "new"; }

    loop {
        $phone-number = prompt "Please enter {$text} phone number: ";
        last if $phone-number ~~ / ^ [[\d ** 10] | [[\d ** 3 "-"] ** 2 \d ** 4]] $ /;
    }
    
    $phone-number;
}

sub prompt-for-changes(--> Str) {
    loop {
        $_ = prompt "Do you want to edit your phone number [y/N]? ";
        last if $_ ~~ YesOrNoResponse;
    }

    $_;
}    
    

say prompt-for-number();
say prompt-for-number() if prompt-for-changes() ~~ YesResponse;
