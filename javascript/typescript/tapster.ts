class Card {
  cardNumber: string;
  cardholderName: string;
  balance = 0;
  ouncesPoured = 0;

  constructor(cardNumber: string, cardholderName: string) {
    this.cardNumber = cardNumber;
    this.cardholderName = cardholderName;
  }

  displayStats() {
    console.log(`Cardholder name: ${this.cardholderName}`);
    console.log(`Ounces poured: ${this.ouncesPoured.toFixed(2)}`);
    console.log(`Total balance: \$${this.balance.toFixed(2)}`);
  }
}

enum ReaderEventType {
  INSERTED,
  CHARGED,
  REMOVED
}

class ReaderEvent {
  eventType: ReaderEventType;
  timestamp = Date.now();
  payload: unknown;

  constructor(eventType: ReaderEventType, payload: unknown) {
    this.eventType = eventType;
    this.payload = payload;
  }
}

class Reader {
  currentCard?: Card | null = null;
  events: ReaderEvent[] = [];

  insertCard(newCard: Card) {
    if (this.currentCard instanceof Card) this.removeCard();
    this.events.push(new ReaderEvent(ReaderEventType.INSERTED, newCard.cardholderName));
    this.currentCard = newCard;
  }

  chargeInsertedCard(ouncesPoured: number, pricePerOunce: number) {
    if (!this.currentCard) return;
    const newCharge = ouncesPoured * pricePerOunce;
    this.events.push(new ReaderEvent(ReaderEventType.CHARGED, newCharge / 10000));
    this.currentCard.ouncesPoured += ouncesPoured / 100;
    this.currentCard.balance += newCharge / 10000;
  }

  chargeNewCard(newCard: Card, ouncesPoured: number, pricePerOunce: number) {
    if (!newCard) return;
    this.insertCard(newCard);
    this.chargeInsertedCard(ouncesPoured, pricePerOunce);
  }

  displayEvents() {
    this.events.forEach(event => {
      console.log(`Event Type: ${ReaderEventType[event.eventType]}`);
      console.log(`Timestamp: ${event.timestamp}`);
      console.log(`Payload: ${event.payload}`);
      console.log();
    });
  }

  removeCard() {
    if (!this.currentCard) return;
    this.events.push(new ReaderEvent(ReaderEventType.REMOVED, this.currentCard.cardholderName));
    this.currentCard = null;
  }
}

const card = new Card("5555555555555555", "Ray Perry");
const reader = new Reader();

reader.insertCard(card);
reader.chargeInsertedCard(1010, 79);
reader.chargeNewCard(card, 430, 94);
reader.chargeNewCard(card, 190, 146);
reader.removeCard();

reader.displayEvents();
card.displayStats();
