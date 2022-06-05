package;

abstract RoundedFloat(Float) from Float {
  static inline var multiplier = 100;

  inline function new(value: Float) {
    this = value;
  }

  @:to inline public function toFloat(): Float {
    return roundFloat(this);
  }

  @:to inline public function toString(): String {
    return Std.string(toFloat());
  }

  static inline function roundFloat(value: Float) {
    return Math.round(value * multiplier) / multiplier;
  }
}

@:structInit
class Card {
  public var number: String;
  public var cardholderName: String;
  public var balance: Float = 0.00;
  public var ouncesPoured: Float = 0.00;
}

enum ReaderEventType { INSERTED; CHARGED; REMOVED; }

@:structInit
class ReaderEvent {
  public var eventType: ReaderEventType;
  public var timestamp: Float = Date.now().getTime();
  public var payload: Dynamic;

  public inline function toString() {
    return 'Event Type: ${this.eventType}\nTimestamp: ${this.timestamp}\nPayload: ${this.payload}\n';
  }
}

@:structInit
class Reader {
  public var currentCard: Card = null;
  public var events: Array<ReaderEvent> = [];

  public function insertCard(card: Card) {
    events.push({ eventType: INSERTED, payload: card.cardholderName });
    this.currentCard = card;
  }

  public function chargeCard(ouncesPoured: Float, pricePerOunce: Float) {
    var newCharge = ouncesPoured * pricePerOunce;
    events.push({ eventType: CHARGED, payload: newCharge });
    this.currentCard.ouncesPoured += ouncesPoured;
    this.currentCard.balance += newCharge;
  }
  
  public function removeCard() {
    events.push({ eventType: REMOVED, payload: this.currentCard.cardholderName });
    this.currentCard = null;
  }

  public function displayStats() {
    if (this.currentCard == null) return;
    trace("Cardholder Name: " + this.currentCard.cardholderName);
    trace("Ounces Poured: " + (this.currentCard.ouncesPoured: RoundedFloat));
    trace("Balance: $" + (this.currentCard.balance: RoundedFloat));
    for (event in this.events) { trace("\n" + event); }
  }
}

function main() {
  var newCard: Card = { number: "5555555555555555", cardholderName: "Ray Perry" };
  var newReader: Reader = {};

  newReader.insertCard(newCard);
  newReader.chargeCard(10.1, 0.50);
  newReader.removeCard();
  newReader.insertCard(newCard);
  newReader.chargeCard(4.3, 0.79);
  newReader.displayStats();
  newReader.removeCard();
}