use v6;

grammar AMPMTime {
    rule TOP {
        # { say "Starting parse" }
        ^^
        # { say "Getting the hours" }
        <hours>
        # { say "Getting the colon" }
        ":"
        # { say "Getting minutes" }
        <minutes>
        # { say "Getting the space" }
        <.ws>
        # { say "Getting AM/PM" }
        <ampm>
        # { say "Ending parse" }
        $$
    }

    regex hours {
       <[0|1]>* <[0..9]>
    }

    token minutes {
        <[0..5]> <[0..9]>
    }

    token ampm {
        "AM"|"PM"
    }
}

sub convert12HTo24H(Str $rawTime) {
    my $parsedTime = AMPMTime.parse($rawTime);
    my %formattedTime = hours => Int($parsedTime<hours>), minutes => Int($parsedTime<minutes>);
    %formattedTime<hours> = 0 if %formattedTime<hours> == 12 && $parsedTime<ampm> ~~ "AM";
    %formattedTime<hours> += 12 if %formattedTime<hours> < 12 && $parsedTime<ampm> ~~ "PM";
    return %formattedTime;
}

for ("AM", "PM") -> $ampm {
    for 1..12 {
        my %testTime = convert12HTo24H($_ ~ ":00 " ~ $ampm);
        say sprintf "%.2d:%.2d", %testTime<hours>, %testTime<minutes>;
    }
}
