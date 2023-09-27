package main

import "core:fmt"
import "core:time"

Card :: struct {
  number: string,
  cardholder_name: string,
  balance: f32,
  ounces_poured: f32
}

ReaderEventType :: enum {INSERTED, CHARGED, REMOVED}

ReaderEvent :: struct {
  event_type: ReaderEventType,
  timestamp: i64,
  payload: string
}

new_reader_event :: proc (event_type: ReaderEventType, payload: string) -> ReaderEvent {
  using time
  return ReaderEvent{event_type, time_to_unix(now()), payload}
}

Reader :: struct {
  current_card: ^Card,
  events: [dynamic]ReaderEvent
}

insert_card :: proc (reader: ^Reader, card: ^Card) {
  using reader
  append(&events, new_reader_event(.INSERTED, card.cardholder_name))
  current_card = card
}

remove_card :: proc (reader: ^Reader) {
  using reader
  append(&events, new_reader_event(.REMOVED, current_card.cardholder_name))
  current_card = nil
}

charge_card :: proc (reader: ^Reader, ounces_poured: f32, price_per_ounce: f32) {
  using reader
  if current_card == nil {
    return
  }

  charge := ounces_poured * price_per_ounce
  append(&events, new_reader_event(.CHARGED, fmt.aprint(charge)))
  current_card.ounces_poured += ounces_poured
  current_card.balance += charge
}

display_stats :: proc (reader: ^Reader) {
  using reader
  if current_card != nil {
    fmt.printf("Cardholder: %s\n", current_card.cardholder_name)
    fmt.printf("Total Amount: $%.2f\n", current_card.balance)
    fmt.printf("Ounces Poured: %.2f\n", current_card.ounces_poured)
  }

  fmt.println()

  for event in events {
    fmt.println(event)
  }
}

main :: proc () {
  card: Card
  card.cardholder_name = "Ray Perry"
  card.number = "5555555555555555"
  
  reader: Reader

  insert_card(&reader, &card)
  charge_card(&reader, 10, 0.50)
  remove_card(&reader)
  insert_card(&reader, &card)
  display_stats(&reader)
}
