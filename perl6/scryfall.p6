use WWW;
use URI::Encode;

my $scryfall_url = 'https://api.scryfall.com/cards/search?q=';

sub print_card(%card_face, %other_card_face?) {
    say %card_face{'name'} ~ ' ' ~ (%card_face{'mana_cost'} if so %card_face{'mana_cost'});
    say "%card_face{'type_line'}";
    say "(This card transforms into %other_card_face{'name'}.)" if so %other_card_face;
    say %card_face{'oracle_text'} if so %card_face{'oracle_text'};
    print "\n";
}

sub MAIN(*@query) {
    my %search_results = jget $scryfall_url ~ uri_encode(@query.join(' '));
    CATCH {
        default { say "No cards found."; }
    }

    return if ! %search_results;
    
    for %search_results{'data'}.flat -> %card {
        print_card(%card{'card_faces'}[0], %card{'card_faces'}[1]) if %card{'card_faces'};
        print_card(%card) unless %card{'card_faces'};
    }
}

# Local Variables:
# compile-command: "perl6 ./scryfall.p6 alpha"
# End:
