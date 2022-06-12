package;

@:structInit
class InventoryItem {
  public var id: String;
  public var name: String;
  public var price: Int;
}

enum StoreEventType {
  PURCHASED;
  REFUNDED;
}

@:structInit
class StoreEvent {
  public var eventType: StoreEventType;
  public var timestamp = Date.now().getTime();
  public var payload: Dynamic;
}

@:structInit
class Store {
  public var name: String;
  public var openingTime = 900;
  public var closingTime = 2100;
  public var stock: Map<String, Int> = [];
  public var events: Array<StoreEvent> = [];

  public function updateItemQuantity(item: InventoryItem, amount: Int) {
    this.stock.set(item.id, amount);
  }

  public function purchaseItem(item: InventoryItem) {
    var currentItemStock = this.stock[item.id];
    if (currentItemStock == null || currentItemStock <= 0) return;
    this.events.push({ eventType: PURCHASED, payload: item.id });
    this.updateItemQuantity(item, currentItemStock - 1);
  }

  public function refundItem(item: InventoryItem) {
    var currentItemStock = this.stock[item.id];
    this.events.push({ eventType: REFUNDED, payload: item.id });
    this.updateItemQuantity(item, currentItemStock + 1);
  }
}

function main() {
  var item1: InventoryItem = { id: "1", name: "Item 1 - A", price: 500 };
  var item2: InventoryItem = { id: "2", name: "Item 2 - B", price: 750 };
  var item3: InventoryItem = { id: "3", name: "Item 3 - C", price: 1000 };

  var store: Store = { name: "Bob's Shop" };

  store.updateItemQuantity(item1, 10);
  store.updateItemQuantity(item2, 7);
  store.updateItemQuantity(item3, 5);

  store.purchaseItem(item1);

  trace(store.stock);
}