package main

import (
	"fmt"
	"time"
)

type Card struct {
	Number         string
	CardholderName string
	Balance        float64
	OuncesPoured   float64
}

type ReaderEventType string

const (
	INSERTED ReaderEventType = "INSERTED"
	CHARGED  ReaderEventType = "CHARGED"
	REMOVED  ReaderEventType = "REMOVED"
)

type ReaderEvent struct {
	EventType ReaderEventType
	Timestamp int64
	Payload   string
}

type Reader struct {
	CurrentCard *Card
	Events      []ReaderEvent
}

func (r *Reader) InsertCard(card *Card) {
	r.Events = append(r.Events, ReaderEvent{
		EventType: INSERTED,
		Timestamp: time.Now().UnixMilli(),
		Payload:   card.CardholderName,
	})
	r.CurrentCard = card
}

func (r *Reader) ChargeCard(ouncesPoured, pricePerOunce float64) {
	if r.CurrentCard == nil {
		return
	}
	
	charge := ouncesPoured * pricePerOunce
	r.Events = append(r.Events, ReaderEvent{
		EventType: CHARGED,
		Timestamp: time.Now().UnixMilli(),
		Payload:   fmt.Sprintf("%.2f", charge),
	})
	
	r.CurrentCard.OuncesPoured += ouncesPoured
	r.CurrentCard.Balance += charge
}

func (r *Reader) RemoveCard() {
	if r.CurrentCard == nil {
		return
	}
	
	r.Events = append(r.Events, ReaderEvent{
		EventType: REMOVED,
		Timestamp: time.Now().UnixMilli(),
		Payload:   r.CurrentCard.CardholderName,
	})
	
	r.CurrentCard = nil
}

func (r *Reader) DisplayStats() {
	if r.CurrentCard != nil {
		fmt.Printf("Cardholder: %s\n", r.CurrentCard.CardholderName)
		fmt.Printf("Total Amount: $%.2f\n", r.CurrentCard.Balance)
		fmt.Printf("Ounces Poured: %.2f\n", r.CurrentCard.OuncesPoured)
	}

	fmt.Println("\nEvents:")
	for _, event := range r.Events {
		fmt.Printf("%d - %s - %s\n", event.Timestamp, event.EventType, event.Payload)
	}
}

func main() {
	card := &Card{
		Number:         "5555555555555555",
		CardholderName: "Ray Perry",
	}
	
	reader := &Reader{
		Events: make([]ReaderEvent, 0),
	}
	
	reader.InsertCard(card)
	reader.ChargeCard(10.0, 0.50)
	reader.DisplayStats()
	reader.RemoveCard()
	reader.InsertCard(card)
	reader.ChargeCard(5.0, 0.75)
	reader.DisplayStats()
}
