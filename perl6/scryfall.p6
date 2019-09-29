use v6;
use WWW;
use URI::Escape;

my $scryfall-url = 'https://api.scryfall.com/cards/search?q=';

sub print-card(%card-face, %other-card-face?) {
    put %card-face{'name'} ~ ' ' ~ (%card-face{'mana_cost'} if %card-face{'mana_cost'});
    put %card-face{'type_line'};
    put "(This card transforms into %other-card-face{'name'}.)" if so %other-card-face;
    put %card-face{'oracle_text'} if %card-face{'oracle_text'};
    print "\n";
}

sub MAIN(
    Str :$query! #= The query you want to search on.
) {
    my %search-results = jget $scryfall-url ~ uri-escape($query);
    CATCH {
        default { put "No cards found."; }
    }

    return if not %search-results;
    
    for %search-results{'data'}.flat -> %card {
        print-card(%card{'card-faces'}[0], %card{'card-faces'}[1]) if %card{'card-faces'};
        print-card(%card) unless %card{'card-faces'};
    }
}

# Local Variables:
# compile-command: "perl6 ./scryfall.p6 --query='t:legend t:creature ci=bug'"
# End:
