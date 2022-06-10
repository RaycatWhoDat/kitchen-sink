class InventoryItem {
  String id;
  String name;
  int price;

  InventoryItem(this.id, this.name, this.price);
}

enum StoreEventType {
  PURCHASED,
  REFUNDED
}

class StoreEvent {
  StoreEventType eventType;
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  var payload;

  StoreEvent(this.eventType, this.payload);
}

class Store {
  String name;
  int openingTime = 900;
  int closingTime = 2100;
  Map<String, int> stock = {};
  List<StoreEvent> events = [];

  Store(this.name);
  
  updateItemQuantity(InventoryItem item, int amount) {
    stock.update(item.id, (value) => amount, ifAbsent: () => amount);
  }

  purchaseItem(InventoryItem item) {
    var currentItemStock = stock[item.id] ?? 0;
    if (currentItemStock <= 0) return;
    events.add(StoreEvent(StoreEventType.PURCHASED, item.id));
    updateItemQuantity(item, currentItemStock - 1);
  }

  refundItem(InventoryItem item) {
    var currentItemStock = stock[item.id] ?? 0;
    events.add(StoreEvent(StoreEventType.REFUNDED, item.id));
    updateItemQuantity(item, currentItemStock + 1);
  }
}

main() {
  var item1 = InventoryItem("1", "Item 1 - A", 500);
  var item2 = InventoryItem("2", "Item 2 - B", 750);
  var item3 = InventoryItem("3", "Item 3 - C", 1000);
  
  var store = Store("Bob's Shop");

  store.updateItemQuantity(item1, 10);
  store.updateItemQuantity(item2, 7);
  store.updateItemQuantity(item3, 5);

  store.purchaseItem(item1);

  print(store.stock);
}
