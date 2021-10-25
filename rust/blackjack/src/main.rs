#[derive(Debug)]
struct Card {
    display_string: String,
    value: [usize; 2]
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

struct Deck {
    cards: Vec<Card>
}

impl Deck {
    fn new() -> Deck {
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
    let deck = Deck::new();
    println!("{:?}", deck.cards[13]);
}
