import Foundation

class Card {
    var number: String
    var cardholderName: String
    var balance: Float = 0.0
    var ouncesPoured: Float = 0.0

    init(_ number: String, _ cardholderName: String) {
        self.number = number
        self.cardholderName = cardholderName
    }
}

enum ReaderEventType {
    case INSERTED, CHARGED, REMOVED
}

struct ReaderEvent: CustomStringConvertible {
    var eventType: ReaderEventType
    var timestamp = Int(Date().timeIntervalSince1970 * 1000)
    var payload: String

    public var description: String {
        return "\(timestamp) - \(eventType) - \(payload)"
    }
}

struct Reader {
    var currentCard: Card? = nil
    var events: [ReaderEvent] = []

    mutating func insertCard(_ card: inout Card) {
        events.append(ReaderEvent(eventType: .INSERTED, payload: card.number))
        currentCard = card
    }

    mutating func removeCard() {
        events.append(ReaderEvent(eventType: .REMOVED, payload: card.number))
        currentCard = nil
    }

    mutating func chargeCard(_ ouncesPoured: Float, _ pricePerOunce: Float) {
        guard currentCard != nil else { return }
        
        let charge = ouncesPoured * pricePerOunce
        events.append(ReaderEvent(eventType: .CHARGED, payload: String(format: "%.2f", charge)))
        currentCard!.balance += charge
        currentCard!.ouncesPoured += ouncesPoured
    }

    func displayStats() {
        if currentCard != nil {
            print("Cardholder: \(currentCard!.cardholderName)")
            print(String(format: "Total Amount: $%.2f", currentCard!.balance))
            print(String(format: "Ounces Poured: %.2f", currentCard!.ouncesPoured))
        }

        print()

        for event in events {
            print(event)
        }
    }
}

var card = Card("5555555555555555","Ray Perry")
var reader = Reader()

reader.insertCard(&card)
reader.chargeCard(10.1, 0.79)
reader.removeCard()
reader.insertCard(&card)
reader.displayStats()
