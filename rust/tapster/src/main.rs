#![allow(dead_code)]
use chrono::Utc;

#[derive(Clone, Debug)]
struct Card {
    number: String,
    cardholder_name: String,
    balance: f32,
    ounces_poured: f32
}

#[derive(Clone)]
enum ReaderEventType {
    INSERTED,
    CHARGED,
    REMOVED
}

#[derive(Clone)]
struct ReaderEvent {
    event_type: ReaderEventType,
    timestamp: i64,
    payload: String
}

#[derive(Clone)]
struct Reader {
    current_card: Option<Card>,
    events: Vec<ReaderEvent>
}

impl Reader {
    fn insert_card(&mut self, card: Card) {
        self.events.push(ReaderEvent {
            event_type: ReaderEventType::INSERTED,
            timestamp: Utc::now().timestamp(),
            payload: card.cardholder_name.clone()
        });
        self.current_card = Some(card);
    }

    fn charge_card(&mut self, ounces_poured: f32, price_per_ounce: f32) {
        let new_charge = ounces_poured * price_per_ounce;
        
        self.events.push(ReaderEvent {
            event_type: ReaderEventType::CHARGED,
            timestamp: Utc::now().timestamp(),
            payload: new_charge.to_string()
        });

        if let Some(card) = self.current_card.as_mut() {
            card.balance += new_charge;
            card.ounces_poured += ounces_poured;
        }
    }

    fn remove_card(&mut self) {
        if let Some(card) = self.current_card.as_mut() {
            self.events.push(ReaderEvent {
                event_type: ReaderEventType::REMOVED,
                timestamp: Utc::now().timestamp(),
                payload: card.cardholder_name.clone()
            });
            self.current_card = None;
        }
    }
}

fn main() {
    let new_card = Card {
        number: "5555555555555555".to_string(),
        cardholder_name: "Ray Perry".to_string(),
        balance: 0.00,
        ounces_poured: 0.00
    };

    let mut new_reader = Reader {
        current_card: None,
        events: vec![]
    };

    new_reader.insert_card(new_card.clone());
    new_reader.charge_card(10.1, 0.79);
    println!("{:?}", new_reader.current_card.as_ref().unwrap());
    new_reader.remove_card();
}
