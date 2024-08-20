import std
import date_time
import dictionary

class Card:
    number: string
    cardholder_name: string
    balance: float
    ounces_poured: float

constructor Card(number, cardholder_name):
    return Card { number, cardholder_name, 0.0, 0.0 }

enum ReaderEventType:
    inserted
    charged
    removed

let reader_event_type_mapping = ["INSERTED", "CHARGED", "REMOVED"]
    
class ReaderEvent:
    event_type: ReaderEventType
    timestamp: int
    payload: string

constructor ReaderEvent(event_type, payload):
    return ReaderEvent { event_type, date_time()[dt_epoch], payload }

class Reader:
    current_card: Card?
    events: [ReaderEvent]

    def insert_card(card):
        events.push(ReaderEvent(inserted, card.cardholder_name))
        current_card = card

    def remove_card():
        if not current_card: return
        events.push(ReaderEvent(removed, current_card.cardholder_name))
        current_card = nil

    def charge_card(ounces_poured, price_per_ounce):
        if not current_card: return
        let charge = ounces_poured * price_per_ounce
        events.push(ReaderEvent(charged, string(charge)))
        current_card.ounces_poured += ounces_poured
        current_card.balance += charge

    def display_stats():
        if current_card:
            print("Cardholder: ", current_card.cardholder_name)
            print("Total Amount: ", current_card.balance)
            print("Ounces Poured: ", current_card.ounces_poured)
            print("")
        print("Events: ")
        for(events) event:
            print(concat_string([string(event.timestamp), "-", reader_event_type_mapping[event.event_type], "-", event.payload], " "))

constructor Reader():
    return Reader { nil, [] }

let card = Card("5555555555555555", "Ray Perry")
let reader = Reader()

reader.insert_card(card)
reader.charge_card(10.3, 0.79)
reader.remove_card()
reader.insert_card(card)
reader.display_stats()
