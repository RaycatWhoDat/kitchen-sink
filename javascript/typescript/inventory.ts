class InventoryItem {
  id: string;
  name: string;
  price: number;

  constructor(id: string, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

enum StoreEventType {
  PURCHASED,
  REFUNDED
}

class StoreEvent {
  eventType: StoreEventType;
  timestamp = Date.now();
  payload: unknown;

  constructor(eventType: number, payload: unknown) {
    this.eventType = eventType;
    this.payload = payload;
  }
}

class Store {
  name: string;
  openingTime = 900;
  closingTime = 2100;
  stock: Record<string, number> = {};
  events: StoreEvent[] = [];

  constructor(name: string) {
    this.name = name;
  }

  updateItemQuantity(item: InventoryItem, amount: number) {
    this.stock[item.id] = amount;
  }

  purchaseItem(item: InventoryItem) {
    const currentItemStock = this.stock[item.id] || 0;
    if (currentItemStock <= 0) return;
    this.events.push(new StoreEvent(StoreEventType.PURCHASED, item.id));
    this.updateItemQuantity(item, this.stock[item.id] - 1);
  }

  refundItem(item: InventoryItem) {
    this.events.push(new StoreEvent(StoreEventType.REFUNDED, item.id));
    this.updateItemQuantity(item, this.stock[item.id] + 1);
  }
}

const item1 = new InventoryItem("1", "Item 1 - A", 500);
const item2 = new InventoryItem("2", "Item 2 - B", 750);
const item3 = new InventoryItem("3", "Item 3 - C", 1000);

const store = new Store("Bob's Shop");

store.updateItemQuantity(item1, 10);
store.updateItemQuantity(item2, 7);
store.updateItemQuantity(item3, 5);

store.purchaseItem(item1);

console.log(store.stock);
