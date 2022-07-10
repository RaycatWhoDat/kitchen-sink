import datetime
from enum import Enum

class InventoryItem:
    def __init__(self, id, name, price):
        self.id = id
        self.name = name
        self.price = price

class StoreEventType(Enum):
    PURCHASED = 1
    REFUNDED = 2

class StoreEvent:
    def __init__(self, event_type, payload):
        self.event_type = event_type
        self.timestamp = datetime.datetime.now()
        self.payload = payload

class Store:
    stock = {}
    events = []

    def __init__(self, name):
        self.name = name

    def update_item_quantity(self, item, amount):
        self.stock[item.id] = amount

    def purchase_item(self, item):
        if self.stock[item.id] < 1:
            return
        self.events.append(StoreEvent(event_type = StoreEventType.PURCHASED, payload = item.id))
        self.update_item_quantity(item, self.stock[item.id] - 1)

    def refund_item(self, item):
        self.events.append(StoreEvent(event_type = StoreEventType.REFUNDED, payload = item.id))
        self.update_item_quantity(item, self.stock[item.id] + 1)

item1 = InventoryItem(id = "1", name = "Item 1 - A", price = 500)
item2 = InventoryItem(id = "2", name = "Item 2 - B", price = 750)
item3 = InventoryItem(id = "3", name = "Item 3 - C", price = 1000)

store = Store(name = "Bob's Shop");

store.update_item_quantity(item1, 10);
store.update_item_quantity(item2, 7);
store.update_item_quantity(item3, 5);

store.purchase_item(item1);

print(store.stock);
