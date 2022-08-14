import Foundation

struct InventoryItem {
    var id: String
    var name: String
    var price: Float
}

enum StoreEventType {
    case PURCHASED
    case REFUNDED
}

struct StoreEvent {
    var eventType: StoreEventType
    var timestamp: Date? = Date()
    var payload: Any
}

class Store {
    var name: String
    var openingTime: Int?
    var closingTime: Int?
    var stock: [String: Int] = [:]
    var events: [StoreEvent] = []

    init(name: String) {
        self.name = name
    }
    
    func updateItemQuantity(item: InventoryItem, amount: Int) {
        self.stock[item.id] = amount
    }

    func purchaseItem(item: InventoryItem) {
        guard self.stock[item.id] ?? 0 > 0 else { return }
        self.events.append(StoreEvent(eventType: StoreEventType.PURCHASED, payload: item.id))
        self.updateItemQuantity(item: item, amount: self.stock[item.id]! - 1)
    }

    func refundItem(item: InventoryItem) {
        self.events.append(StoreEvent(eventType: StoreEventType.REFUNDED, payload: item.id))
        self.updateItemQuantity(item: item, amount: (self.stock[item.id] ?? 0) + 1)
    }
}

let item1 = InventoryItem(id: "1", name: "Item 1 - A", price: 500)
let item2 = InventoryItem(id: "2", name: "Item 2 - B", price: 750)
let item3 = InventoryItem(id: "3", name: "Item 3 - C", price: 1000)

var store = Store(name: "Bob's Shop")

store.updateItemQuantity(item: item1, amount: 10)
store.updateItemQuantity(item: item2, amount: 7)
store.updateItemQuantity(item: item3, amount: 5)

store.purchaseItem(item: item1)

print(store.stock)
