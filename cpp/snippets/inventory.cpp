#include <iostream>
#include <string>
#include <map>

class InventoryItem
{
public:
  std::string id;
  std::string name;
  unsigned int price;
  InventoryItem(std::string _id, std::string _name, unsigned int _price) : id(_id), name(_name), price(_price) {}
};

enum StoreEventType
{
  PURCHASED,
  REFUNDED
};

class StoreEvent
{
public:
  StoreEventType eventType;
  unsigned int timestamp;
  std::string payload;
  StoreEvent(StoreEventType _eventType, std::string _payload) : eventType(_eventType), payload(_payload) {
    timestamp = 0;
  }
};

class Store
{
  unsigned int openingTime;
  unsigned int closingTime;
  std::map<std::string, unsigned int> stock;
  std::vector<StoreEvent> events;

public:
  std::string name;

  Store(std::string _name) : name(_name) {
    openingTime = 900;
    closingTime = 1700;
  }
  
  void updateItemQuantity(InventoryItem* item, unsigned int amount) {
    stock[item->id] = amount;
  }
  
  void purchaseItem(InventoryItem* item) {
    if (stock[item->id] <= 0) {
      return;
    }

    StoreEvent storeEvent = StoreEvent(PURCHASED, item->id);
    events.push_back(storeEvent);

    updateItemQuantity(item, stock[item->id] - 1);
  }
  
  void refundItem(InventoryItem* item) {
    StoreEvent storeEvent = StoreEvent(REFUNDED, item->id);
    events.push_back(storeEvent);

    updateItemQuantity(item, stock[item->id] + 1);
  }
  
  void getStoreStatus() {
    for (const auto& entry : stock) {
      std::cout << entry.first << ": " << entry.second << std::endl;
    }
  }
};

int main() {
  InventoryItem item1 = InventoryItem("1", "Item 1 - A", 500);
  InventoryItem item2 = InventoryItem("2", "Item 2 - B", 750);
  InventoryItem item3 = InventoryItem("3", "Item 3 - C", 1000);

  Store store = Store("Bob's Shop");
  
  store.updateItemQuantity(&item1, 10);
  store.updateItemQuantity(&item2, 7);
  store.updateItemQuantity(&item3, 5);

  store.purchaseItem(&item1);

  store.getStoreStatus();
}

// Local Variables:
// compile-command: "g++ -std=c++11 -Wall -Wextra -fsanitize=address -o inventory inventory.cpp && ./inventory"
// End:
