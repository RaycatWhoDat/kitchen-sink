#![allow(dead_code)]

use std::collections::HashMap;
use chrono::Utc;

struct InventoryItem {
    id: &'static str,
    name: &'static str,
    price: i32
}

#[derive(Debug)]
enum StoreEventType {
    PURCHASED,
    REFUNDED
}

#[derive(Debug)]
struct StoreEvent<'a> {
    event_type: StoreEventType,
    timestamp: i64,
    payload: &'a str
}

impl StoreEvent<'_> {
    fn new(event_type: StoreEventType, payload: &'static str) -> Self {
        Self {
            event_type,
            timestamp: Utc::now().timestamp(),
            payload
        }
    } 
}

struct Store<'a> {
    name: &'a str,
    opening_time: i32,
    closing_time: i32,
    stock: HashMap<&'a str, i32>,
    events: Vec<StoreEvent<'a>>
}

impl Store<'_> {
    fn update_item_quantity(&mut self, item: &InventoryItem, amount: i32) {
        self.stock
            .entry(item.id)
            .and_modify(|entry| *entry = amount)
            .or_insert(amount);
    }

    fn purchase_item(&mut self, item: &InventoryItem) {
        self.events.push(StoreEvent::new(StoreEventType::PURCHASED, item.id));
        let current_item_stock = self.stock.get(&item.id).unwrap().to_owned();
        self.update_item_quantity(item, current_item_stock - 1);
    }

    fn refund_item(&mut self, item: &InventoryItem) {
        self.events.push(StoreEvent::new(StoreEventType::REFUNDED, item.id));
        let current_item_stock = self.stock.get(&item.id).unwrap().to_owned();
        self.update_item_quantity(item, current_item_stock + 1);
    }

    fn print_events(&mut self) {
        for event in self.events.iter() { 
            println!("{:?}", event);
        }
    }
}


fn main() {
    let item1 = InventoryItem {
        id: "1",
        name: "Item 1 - A",
        price: 500
    };

    let item2 = InventoryItem {
        id: "2",
        name: "Item 2 - B",
        price: 750
    };

    let item3 = InventoryItem {
        id: "3",
        name: "Item 3 - C",
        price: 1000
    };
    
    let mut store = Store {
        name: "Bob's Shop",
        opening_time: 800,
        closing_time: 2100,
        stock: HashMap::new(),
        events: vec![]
    };

    store.update_item_quantity(&item1, 10);
    store.update_item_quantity(&item2, 7);
    store.update_item_quantity(&item3, 5);

    store.purchase_item(&item1);
    store.purchase_item(&item2);
    store.purchase_item(&item3);
    store.refund_item(&item1);
    
    store.print_events();
    
}
