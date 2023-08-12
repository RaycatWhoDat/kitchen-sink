package main

import (
	"fmt"
	"time"
)

type card struct {
	number         string
	cardholderName string
	balance        float64
	ouncesPoured   float64
}

type readerEventType string

const (
	INSERTED readerEventType = "INSERTED"
	CHARGED                  = "CHARGED"
	REMOVED                  = "REMOVED"
)

type readerEvent struct {
	eventType readerEventType
	payload   string
	timestamp int64
}

type reader struct {
	currentCard *card
	events      []readerEvent
}

func (r *reader) insertCard(c *card) {
	r.events = append(r.events, readerEvent{INSERTED, c.cardholderName, time.Now().UnixMilli()})
	r.currentCard = c
}

func (r *reader) removeCard() {
	r.events = append(r.events, readerEvent{REMOVED, r.currentCard.cardholderName, time.Now().UnixMilli()})
	r.currentCard = nil
}

func (r *reader) chargeCard(ouncesPoured float64, pricePerOunce float64) {
	if r.currentCard == nil {
		return
	}
	charge := ouncesPoured * pricePerOunce
	r.events = append(r.events, readerEvent{CHARGED, fmt.Sprint(charge), time.Now().UnixMilli()})
	r.currentCard.ouncesPoured += ouncesPoured
	r.currentCard.balance += charge
}

func (r *reader) displayStats() {
	if r.currentCard != nil {
		fmt.Printf("Cardholder: %s\n", r.currentCard.cardholderName)
		fmt.Printf("Total Amount: $%.2f\n", r.currentCard.balance)
		fmt.Printf("Ounces Poured: %.2f\n", r.currentCard.ouncesPoured)
	}

	fmt.Println("Events: ")
	for _, event := range r.events {
		fmt.Printf("%d - %s - %s\n", event.timestamp, event.eventType, event.payload)
	}
}

func main() {
	card1 := card{"5555555555555555", "Ray Perry", 0.0, 0.0}
	reader1 := reader{}

	reader1.insertCard(&card1)
	reader1.chargeCard(10, 0.50)
	reader1.removeCard()
	reader1.displayStats()
}
