from enum import Enum
from datetime import datetime
from dataclasses import dataclass, field
from typing import List, Dict

@dataclass
class InventoryItem:
    id: str
    name: str
    price: int

class StoreEventType(Enum):
    PURCHASED = 1
    REFUNDED = 2

@dataclass
class StoreEvent:
    event_type: StoreEventType
    timestamp: datetime = datetime.now()
    payload: str = ""

@dataclass
class Store:
    name: str
    opening_time: datetime = datetime.now()
    closing_time: datetime = datetime.now()
    stock: Dict[str, int] = field(default_factory = dict)
    events: List[StoreEvent] = field(default_factory = list)

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
