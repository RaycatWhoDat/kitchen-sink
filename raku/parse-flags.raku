use v6;

grammar OptionsParser {
    rule TOP {
        :my %*result;
        ^^ ('-' '-'? <flag-with-values>)+ %% <.ws> $$ {
            make %*result;
        }
    }

    token flag-with-values {
        <flag-name> <.ws> <flag-value> {
            %*result{$<flag-name>} = ~$<flag-value>;
        }
    }
    
    token flag-name {
        <alnum>+
    }

    token flag-value {
        <[a..zA..Z0..9\-]>+
    }
}

sub MAIN() {
    OptionsParser.parse(@*ARGS.join(' ')).made;
}

DOC CHECK {
    use Test;

    subtest "Test case" => {
        my $input = <-a 1 -b 2 -c a-b-c -d four --extended nf062v4v>;
        my %result := {
            'a' => '1',
            'b' => '2',
            'c' => 'a-b-c',
            'd' => 'four',
            'extended' => 'nf062v4v'
        };
        
        my %flags := OptionsParser.parse($input).made;
        %flags.&is(%result);
    }
}
