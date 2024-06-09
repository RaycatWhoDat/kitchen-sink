import rand { intn }
import strconv { parse_int }

const starting_hand_size = 2

struct BlackjackValue {
	display_value string
mut:
	value [2]int
}

struct BlackjackHand {
mut:
	cards []BlackjackValue
	total [2]int
}

struct BlackjackDeck {
mut:
	cards []BlackjackValue
}

fn (mut d BlackjackDeck) hit() BlackjackValue {
	next_card_index := intn(d.cards.len) or { 0 }
	next_card := d.cards[next_card_index]
	d.cards.delete(next_card_index)
	return next_card
}

fn (h BlackjackHand) status() {
	mut card_listing := ''
	for card in h.cards {
		card_listing += card.display_value + ' '
	}
	println(card_listing)
}

fn (mut h BlackjackHand) hit(mut d BlackjackDeck) {
	next_card := d.hit()
	h.cards << next_card
	h.total[0] += next_card.value[0]
	h.total[1] += next_card.value[1]
}

fn BlackjackHand.new(cards []BlackjackValue) BlackjackHand {
	mut total := [2]int{}
	for card in cards {
		total[0] += card.value[0]
		total[1] += card.value[1]
	}
	return BlackjackHand{cards, total}
}

fn (mut d BlackjackDeck) reset() {
	d.cards = []
	for suit in ['♥', '♠', '♦', '♣'] {
		for value in ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'] {
			mut total := [2]int{}
			if value == 'A' {
				total = [1, 11]!
			} else {
				number := parse_int(value, 10, 0) or { 10 }
				total = [int(number), int(number)]!
			}
			d.cards << BlackjackValue{value + suit, total}
		}
	}
}

fn (mut d BlackjackDeck) deal() []BlackjackValue {
	mut cards := []BlackjackValue{}
	for _ in 0 .. starting_hand_size {
		cards << d.hit()
	}
	return cards
}

fn main() {
	mut deck := BlackjackDeck{}
	deck.reset()

	mut player_hand := BlackjackHand.new(deck.deal())
	player_hand.status()

	for {
		player_hand.hit(mut deck)
		player_hand.status()
		if player_hand.total[0] > 21 {
			break
		}
	}

	println("You've busted!")
}
