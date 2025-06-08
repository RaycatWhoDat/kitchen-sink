#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <chrono>

struct Card
{
  std::string number;
  std::string cardholder_name;
  double balance = 0;
  double ounces_poured = 0;
  Card(std::string number, std::string cardholder_name) : number(number), cardholder_name(cardholder_name) {};
};

enum ReaderEventType
{
  INSERTED,
  CHARGED,
  REMOVED
};

std::string reader_event_type_mapping[] = {"INSERTED", "CHARGED", "REMOVED"};

struct ReaderEvent
{
  ReaderEventType event_type;
  unsigned int timestamp;
  std::string payload;
  ReaderEvent(ReaderEventType event_type, std::string payload) : event_type(event_type), payload(payload)
  {
    auto now = std::chrono::system_clock::now();
    auto _timestamp = std::chrono::duration_cast<std::chrono::seconds>(
                          now.time_since_epoch())
                          .count();
    timestamp = _timestamp;
  };
};

class Reader
{
  Card *current_card;
  std::vector<ReaderEvent> events;

public:
  void insert_card(Card *card)
  {
    events.push_back(ReaderEvent(INSERTED, card->cardholder_name));
    current_card = card;
  };

  void charge_card(double ounces_poured, double price_per_ounce)
  {
    if (current_card == nullptr)
      return;
    double charge = ounces_poured * price_per_ounce;
    events.push_back(ReaderEvent(CHARGED, std::to_string(charge)));
    current_card->ounces_poured += ounces_poured;
    current_card->balance += charge;
  };

  void remove_card()
  {
    events.push_back(ReaderEvent(REMOVED, current_card->cardholder_name));
    current_card = nullptr;
  };

  void display_stats()
  {
    if (current_card != nullptr)
    {
      std::cout << "Cardholder: "
                << current_card->cardholder_name
                << std::endl;
      std::cout << "Total Amount: "
                << current_card->balance
                << std::endl;
      std::cout << "Ounces Poured: "
                << current_card->ounces_poured
                << std::endl
                << std::endl;
    }

    std::cout << "Events: " << std::endl;

    std::vector<ReaderEvent>::iterator event;
    for (event = events.begin(); event != events.end(); event++)
    {
      std::cout << event->timestamp << " - " << reader_event_type_mapping[event->event_type] << " - " << event->payload << std::endl;
    }
  }
};

int main()
{
  Reader reader = Reader();
  Card card1 = Card("5555555555555555", "Ray Perry");

  reader.insert_card(&card1);
  reader.charge_card(10.1, 0.79);
  reader.remove_card();
  reader.insert_card(&card1);
  reader.display_stats();

  return 0;
}