import std.stdio: writeln;
import std.datetime: Clock;
import std.array;
import std.container.array;

class InventoryItem {
  string id;
  string name;
  int price;

  public this(string id, string name, int price) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

enum StoreEventType { PURCHASED, REFUNDED }

class StoreEvent {
  StoreEventType eventType;
  string timestamp;
  string payload;

  public this(StoreEventType eventType, string timestamp, string payload) {
    this.eventType = eventType;
    this.timestamp = timestamp;
    this.payload = payload;
  }
}

class Store {
  string name;
  int openingTime = 900;
  int closingTime = 1700;
  int[string] stock;
  auto events = Array!StoreEvent();

  public this(string name) {
    this.name = name;
  }
  
  void updateItemQuantity(InventoryItem item, int amount) {
    this.stock[item.id] = amount;
  }
  
  void purchaseItem(InventoryItem item) {
    if (this.stock[item.id] < 1) return;
    this.events.insertBack(new StoreEvent(StoreEventType.PURCHASED, Clock.currTime().toISOString(), item.id));
    this.updateItemQuantity(item, this.stock[item.id] - 1);
  }
  
  void refundItem(InventoryItem item) {
    this.events.insertBack(new StoreEvent(StoreEventType.REFUNDED, Clock.currTime().toISOString(), item.id));
    this.updateItemQuantity(item, this.stock[item.id] + 1);
  }
}

void main() {
  auto item1 = new InventoryItem("1", "Item 1 - A", 500);
  auto item2 = new InventoryItem("2", "Item 2 - B", 750);
  auto item3 = new InventoryItem("3", "Item 3 - C", 1000);
  
  auto store = new Store("Bob's Shop");

  store.updateItemQuantity(item1, 10);
  store.updateItemQuantity(item2, 7);
  store.updateItemQuantity(item3, 5);

  store.purchaseItem(item1);

  writeln(store.stock);
}

