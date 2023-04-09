#include <iostream>
#include <string>
#include <map>

struct InventoryItem {
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

struct StoreEvent
{
  StoreEventType eventType;
  unsigned int timestamp;
  std::string payload;
  StoreEvent(StoreEventType _eventType, std::string _payload) : eventType(_eventType), payload(_payload) {
    timestamp = 0;
  }
};

class Store
{
  std::string name;
  unsigned int openingTime;
  unsigned int closingTime;
  std::map<std::string, unsigned int> stock;
  std::vector<StoreEvent> events;

public:
  Store(std::string _name) : name(_name) {
    openingTime = 900;
    closingTime = 1700;
  }
  
  void update_item_quantity(InventoryItem& item, unsigned int amount) {
    stock[item.id] = amount;
  }
  
  void purchase_item(InventoryItem& item) {
    if (stock[item.id] <= 0) {
      return;
    }

    events.push_back(StoreEvent(PURCHASED, item.id));
    update_item_quantity(item, stock[item.id] - 1);
  }
  
  void refund_item(InventoryItem& item) {
    events.push_back(StoreEvent(REFUNDED, item.id));
    update_item_quantity(item, stock[item.id] + 1);
  }
  
  void get_store_status() {
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
  
  store.update_item_quantity(item1, 10);
  store.update_item_quantity(item2, 7);
  store.update_item_quantity(item3, 5);

  store.purchase_item(item1);

  store.get_store_status();
}

// Local Variables:
// compile-command: "g++ -std=c++11 -Wall -Wextra -fsanitize=address -o inventory inventory.cpp && ./inventory"
// End:
