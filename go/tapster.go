package main

import (
	"fmt"
	"time"
)

type card struct {
	number string
	cardholderName string
	balance float32
	ouncesPoured float32
}

type readerEventType string

const (
	INSERTED readerEventType = "INSERTED"
	CHARGED = "CHARGED"
	REMOVED = "REMOVED"
)

type readerEvent struct {
	eventType readerEventType
	payload string
	timestamp int64
}

type reader struct {
	currentCard *card
	events []readerEvent
}

func (r *reader) InsertCard(c *card) {
	r.events = append(r.events, readerEvent{ INSERTED, c.cardholderName, time.Now().UnixMilli() })
	r.currentCard = c
}

func (r *reader) RemoveCard() {
	r.events = append(r.events, readerEvent{ REMOVED, r.currentCard.cardholderName, time.Now().UnixMilli() })
	r.currentCard = nil
}

func (r *reader) ChargeCard(ouncesPoured float32, pricePerOunce float32) {
	if r.currentCard == nil { return }
	charge := ouncesPoured * pricePerOunce
	r.events = append(r.events, readerEvent{ CHARGED, r.currentCard.cardholderName, time.Now().UnixMilli() })
	r.currentCard.ouncesPoured += ouncesPoured
	r.currentCard.balance += charge
}

func (r *reader) DisplayStats() {
	if r.currentCard != nil {
		fmt.Printf("Cardholder: %s\n", r.currentCard.cardholderName)
		fmt.Printf("Total Amount: $%.2f\n", r.currentCard.balance)
		fmt.Printf("Ounces Poured: %.2f\n", r.currentCard.ouncesPoured)
	}

	for _, event := range r.events {
		fmt.Printf("%d - %s - %s\n", event.timestamp, event.eventType, event.payload)
	}
}

func main() {
	card1 := card{ "Ray Perry", "5555555555555555", 0.0, 0.0 }
	reader1 := reader{}

	reader1.InsertCard(&card1)
	reader1.ChargeCard(10, 0.50)
	reader1.RemoveCard()
	reader1.DisplayStats()
}
