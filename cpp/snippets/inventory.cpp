#include <iostream>
#include <string>
#include <map>

#include "inventory.hpp"

void Store::updateItemQuantity(InventoryItem item, unsigned int amount) {
  stock[item.id] = amount;
}

void Store::purchaseItem(InventoryItem item) {
  if (stock[item.id] <= 0) {
    return;
  }

  StoreEvent storeEvent = StoreEvent(PURCHASED, item.id);
  events.push_back(storeEvent);

  updateItemQuantity(item, stock[item.id] - 1);
}  

void Store::refundItem(InventoryItem item) {
  StoreEvent storeEvent = StoreEvent(REFUNDED, item.id);
  events.push_back(storeEvent);

  updateItemQuantity(item, stock[item.id] + 1);
}

void Store::getStoreStatus() {
  for (const auto& entry : stock) {
    std::cout << entry.first << ": " << entry.second << std::endl;
  }
}

int main() {
  InventoryItem item1 = InventoryItem("1", "Item 1 - A", 500);
  InventoryItem item2 = InventoryItem("2", "Item 2 - B", 750);
  InventoryItem item3 = InventoryItem("3", "Item 3 - C", 1000);

  Store store = Store("Bob's Shop");
  
  store.updateItemQuantity(item1, 10);
  store.updateItemQuantity(item2, 7);
  store.updateItemQuantity(item3, 5);

  store.purchaseItem(item1);

  store.getStoreStatus();
}
