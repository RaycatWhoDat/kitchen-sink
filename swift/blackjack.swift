import Foundation

enum BlackjackValue {
    case single(Int)
    case double(Int, Int)

    var value: (Int, Int) {
        switch self {
        case .single(let value):
            return (value, value)
        case .double(let value1, let value2):
            return (value1, value2)
        }
    }
}

struct Card {
    let repr: String
    let value: BlackjackValue 
}

struct Deck {
    var cards: [Card] = []

    mutating func shuffle() {
        self.cards = self.cards.shuffled()
    }
    
    mutating func reset() {
        self.cards = []
        for value in 2...14 {
            for suit in ["♥", "♠", "♦", "♣"] {
                var newCard: Card

                switch value {
                case 11: newCard = Card(repr: "J\(suit)", value: BlackjackValue.single(10))
                case 12: newCard = Card(repr: "Q\(suit)", value: BlackjackValue.single(10))
                case 13: newCard = Card(repr: "K\(suit)", value: BlackjackValue.single(10))
                case 14: newCard = Card(repr: "A\(suit)", value: BlackjackValue.double(1, 11))
                default: newCard = Card(repr: "\(value)\(suit)", value: BlackjackValue.single(value))
                }

                self.cards.append(newCard)
            }
        }

        self.shuffle()
    }
    
    mutating func draw() -> Card? {
        guard self.cards.count > 0 else { return nil }
        return self.cards.removeFirst()
    }
}

struct BlackjackHand {
    var cards: [Card] = []
    var total: (Int, Int) = (0, 0)

    func status() {
        print(self.cards)
        print("Total cards: \(self.total)")
    }

    mutating func hit(deck: inout Deck) {
        guard deck.cards.count > 0 else { return }
        let nextCard = deck.draw()!
        let (value1, value2) = nextCard.value.value
        self.total.0 += value1
        self.total.1 += value2
        self.cards.append(nextCard)
    }
}

var deck = Deck()
deck.reset()

var hand = BlackjackHand()
hand.status()
hand.hit(deck: &deck)
hand.hit(deck: &deck)
hand.hit(deck: &deck)

hand.status()
