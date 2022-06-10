#![allow(dead_code)]

use std::collections::HashMap;
use chrono::Utc;

struct InventoryItem {
    id: String,
    name: String,
    price: i32
}

enum StoreEventType {
    PURCHASED,
    REFUNDED
}

struct StoreEvent {
    event_type: StoreEventType,
    timestamp: i64,
    payload: String
}

impl StoreEvent {
    fn new(event_type: StoreEventType, payload: String) -> Self {
        Self {
            event_type,
            timestamp: Utc::now().timestamp(),
            payload
        }
    }
}

struct Store {
    name: String,
    opening_time: i32,
    closing_time: i32,
    stock: HashMap<String, i32>,
    events: Vec<StoreEvent>
}

impl Store {
    fn update_item_quantity(&mut self, item: &InventoryItem, amount: i32) {
        self.stock
            .entry(item.id.clone())
            .and_modify(|entry| *entry = amount)
            .or_insert(amount);
    }

    fn purchase_item(&mut self, item: &InventoryItem) {
        self.events.push(StoreEvent::new(StoreEventType::PURCHASED, item.id.clone()));
        let current_item_stock = self.stock.get(&item.id).unwrap();
        self.update_item_quantity(item, *current_item_stock - 1);
    }

    fn refund_item(&mut self, item: &InventoryItem) {
        self.events.push(StoreEvent::new(StoreEventType::REFUNDED, item.id.clone()));
        let current_item_stock = self.stock.get(&item.id).unwrap();
        self.update_item_quantity(item, *current_item_stock + 1);
    }
}


fn main() {
    let item1 = InventoryItem {
        id: "1".to_string(),
        name: "Item 1 - A".to_string(),
        price: 500
    };

    let item2 = InventoryItem {
        id: "2".to_string(),
        name: "Item 2 - B".to_string(),
        price: 750
    };

    let item3 = InventoryItem {
        id: "3".to_string(),
        name: "Item 3 - C".to_string(),
        price: 1000
    };
    
    let mut store = Store {
        name: "Bob's Shop".to_string(),
        opening_time: 800,
        closing_time: 2100,
        stock: HashMap::new(),
        events: vec![]
    };

    store.update_item_quantity(&item1, 10);
    store.update_item_quantity(&item2, 7);
    store.update_item_quantity(&item3, 5);

    store.purchase_item(&item1);
    
}
