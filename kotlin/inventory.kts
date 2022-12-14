package inventory;

import java.time.LocalDateTime;

data class InventoryItem(
    val id: String,
    val name: String,
    val price: Int
);

enum class StoreEventType {
    PURCHASED,
    REFUNDED
}

data class StoreEvent(
    val eventType: StoreEventType,
    val payload: String,
    val timestamp: LocalDateTime = LocalDateTime.now()
);

class Store(name: String) {
    val name = name;
    val openingTime = 900;
    val closingTime = 1700;
    val stock = mutableMapOf<String, Int>();
    val events = mutableListOf<StoreEvent>();

    fun updateItemQuantity(item: InventoryItem, amount: Int) {
        this.stock.put(item.id, amount);
    }
    
    fun purchaseItem(item: InventoryItem) {
        if (this.stock.getOrDefault(item.id, 0) < 1) {
            return;
        }

        this.events.add(StoreEvent(StoreEventType.PURCHASED, item.id))
        this.updateItemQuantity(item, this.stock.getOrDefault(item.id, 0) - 1);
    }
    
    fun refundItem(item: InventoryItem) {
        this.events.add(StoreEvent(StoreEventType.REFUNDED, item.id))
        this.updateItemQuantity(item, this.stock.getOrDefault(item.id, 0) + 1);
    }
}

val item1 = InventoryItem("1", "Item 1 - A", 500);
val item2 = InventoryItem("2", "Item 2 - B", 750);
val item3 = InventoryItem("3", "Item 3 - C", 1000);

val store = Store("Bob's Shop");

store.updateItemQuantity(item1, 10);
store.updateItemQuantity(item2, 7);
store.updateItemQuantity(item3, 5);

store.purchaseItem(item1);
store.refundItem(item1);

println(store.stock);
