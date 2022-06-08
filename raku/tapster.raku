subset CardNumber of Str where .chars == 16;

class Card {
    has CardNumber $!number;
    has Str $.cardholder-name;
    has Real $.balance is rw = 0;
    has Real $.ounces-poured is rw = 0;
}

enum ReaderEventType <INSERTED CHARGED REMOVED>;

class ReaderEvent {
    has ReaderEventType $.event-type;
    has Int $.timestamp = time;
    has $.payload;
}

class Reader {
    has $.current-card is rw is default(Nil);
    has ReaderEvent @.events = [];

    method insert-card(Card $card) {
        @!events.push: ReaderEvent.new(event-type => INSERTED, payload => $card.cardholder-name);
        $.current-card = $card;
    }

    method charge-card(Real $ounces-poured, Real $price-per-ounce) {
        return if not so $.current-card;
        my $charge = $ounces-poured * $price-per-ounce;
        @!events.push: ReaderEvent.new(event-type => CHARGED, payload => $charge);
        $.current-card.ounces-poured += $ounces-poured;
        $.current-card.balance += $charge;
    }

    method remove-card() {
        @!events.push: ReaderEvent.new(event-type => REMOVED, payload => $.current-card.cardholder-name);
        $.current-card = Nil;
    }

    method display-stats() {
        printf("Cardholder: %s\n", $.current-card.cardholder-name);
        printf("Total Amount: \$%.2f\n", $.current-card.balance);
        printf("Ounces Poured: %.2f\n", $.current-card.ounces-poured);
        say "";
        say "Events: ";
        .say for @.events;
    }
}

DOC CHECK {
    use Test;

    my $card = Card.new(cardholder-name => "Ray Perry", number => "5555555555555555");
    my $reader = Reader.new;

    $reader.insert-card($card);
    $reader.charge-card(10, 0.50);
    $card.balance.&is(5);

    $reader.display-stats;

    $reader.remove-card;
    $reader.current-card.&is(Nil);
    $reader.events.elems.&is(3);

    done-testing;
}
