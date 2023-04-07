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
  
  void updateItemQuantity(InventoryItem item, unsigned int amount);
  void purchaseItem(InventoryItem item);
  void refundItem(InventoryItem item);
  void getStoreStatus();
};
