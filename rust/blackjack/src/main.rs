use std::fmt::{Display, Formatter, Result};
use rand::seq::SliceRandom;

#[derive(Clone, Debug)]
struct Card {
    display_string: String,
    value: [usize; 2]
}

impl Display for Card {
     fn fmt(&self, f: &mut Formatter<'_>) -> Result {
         write!(f, "{}", self.display_string)
    }
}

impl Card {
    fn new(card_value: usize, suit_index: usize) -> Card {
        let suits = vec!["♥", "♠", "♦", "♣"];
        let royals = vec!["J", "Q", "K"];

        let suit = suits[suit_index];
        
        match card_value {
            1 => Card {
                display_string: format!("A{}", suit),
                value: [1, 11]
            },
            2..=10 => Card {
                display_string: format!("{}{}", card_value, suit),
                value: [card_value; 2]
            },
            11 | 12 | 13 => Card {
                display_string: format!("{}{}", royals[card_value - 11], suit),
                value: [10; 2]
            },
            _ => Card {
                display_string: String::new(),
                value: [0; 2]
            }
        }
    }
}

struct Hand {
    current_value: [usize; 2],
    cards: Vec<Card>
}

impl Hand {
    fn new(cards: Vec<Card>) -> Self {
        let mut hand = Hand { current_value: [0, 0], cards: vec![] };
        for card in cards {
            hand.add_card(card);
        }
        hand
    }
    
    fn add_card(&mut self, card: Card) {
        self.current_value[0] += card.value[0];
        self.current_value[1] += card.value[1];
        self.cards.push(card);
    }
    
    fn print_cards(&self) {
        for card in &self.cards {
            print!("{} ", card);
        }
        println!();
    }

    fn print_current_value(&self) {
        println!("Total value: {} ({})", self.current_value[0], self.current_value[1]);
    }
}

struct Deck {
    cards: Vec<Card>
}

impl Deck {
    fn new() -> Self {
        let mut deck = Deck { cards: vec![] };
        deck.generate();
        deck
    }
    
    fn generate(&mut self) {
        self.cards = (0..=51)
            .map(|index| Card::new((index % 13) + 1, index / 13))
            .collect();
    }
}

fn main() {
    let mut rng = &mut rand::thread_rng();
    let deck = Deck::new();
    let hand = Hand::new(deck.cards.choose_multiple(&mut rng, 2).cloned().collect());
    hand.print_current_value();
    hand.print_cards();
}
