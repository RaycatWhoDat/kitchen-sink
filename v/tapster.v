import time

struct Card {
	number          string
	cardholder_name string
mut:
	balance       f32
	ounces_poured f32
}

enum ReaderEventType {
	inserted
	charged
	removed
}

fn (t ReaderEventType) str() string {
	return ['INSERTED', 'CHARGED', 'REMOVED'][t]
}

struct ReaderEvent {
	event_type ReaderEventType
	timestamp  i64
	payload    string
}

fn new_reader_event(event_type ReaderEventType, payload string) ReaderEvent {
	return ReaderEvent{event_type, time.now().days_from_unix_epoch(), payload}
}

struct Reader {
mut:
	current_card ?Card
	events       []ReaderEvent
}

fn (mut r Reader) insert_card(card Card) {
	r.events << new_reader_event(ReaderEventType.inserted, card.cardholder_name)
	r.current_card = card
}

fn (mut r Reader) remove_card() {
	r.events << new_reader_event(ReaderEventType.removed, r.current_card?.cardholder_name)
	r.current_card = none
}

fn (mut r Reader) charge_card(ounces_poured f32, price_per_ounce f32) {
	if r.current_card == none {
		return
	}
	charge := ounces_poured * price_per_ounce
	r.events << new_reader_event(ReaderEventType.charged, '${charge}')
	//    /tmp/v_1000/tapster.873035007828648538.tmp.c:15245: error: field not found: ounces_poured
	//    builder error:
	//    ==================
	//    C error. This should never happen.

	// r.current_card?.ounces_poured += ounces_poured
	// r.current_card?.balance += charge
}

fn (r Reader) display_stats() {
	if r.current_card != none {
		println('Cardholder: ${r.current_card?.cardholder_name}')
		println('Total Amount: ${r.current_card?.balance}')
		println('Ounces Poured: ${r.current_card?.ounces_poured}')
	}

	for event in r.events {
		println(event)
	}
}

mut my_card := Card{'5555555555555555', 'Ray Perry', 0.0, 0.0}
mut my_reader := Reader{}
my_reader.insert_card(my_card)
my_reader.charge_card(10.3, 0.79)
my_reader.remove_card()
my_reader.insert_card(my_card)
my_reader.display_stats()
