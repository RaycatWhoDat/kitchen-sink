(local class (require :pl.class))

(local Card (class.Card))
(fn Card._init [self number cardholder-name] (set self.number number)
  (set self.cardholder_name cardholder-name)
  (set self.balance 0.0)
  (set self.ounces_poured 0.0))

(local ReaderEvent (class.ReaderEvent))
(fn ReaderEvent._init [self event-type payload]
  (set self.event_type event-type)
  (set self.timestamp (os.date "%c"))
  (set self.payload payload))

(fn ReaderEvent.__tostring [self]
  (string.format "%s - %s - %s" self.timestamp self.event_type self.payload))

(local Reader (class.Reader))
(fn Reader._init [self] (set self.events {}))

(fn Reader.insert_card [self card]
  (table.insert self.events (ReaderEvent :CHARGED card.cardholder_name))
  (set self.current_card card))

(fn Reader.charge_card [self ounces-poured price-per-ounce]
  (when (not self.current_card) (lua "return"))
  (local charge (* ounces-poured price-per-ounce))
  (table.insert self.events (ReaderEvent :CHARGED (string.format "$%.2f" charge)))
  (set self.current_card.ounces_poured (+ self.current_card.ounces_poured ounces-poured))
  (set self.current_card.balance (+ self.current_card.balance charge)))

(fn Reader.remove_card [self]
  (table.insert self.events (ReaderEvent :REMOVED self.current_card.cardholder_name))
  (set self.current_card nil))

(fn Reader.display_stats [self]
  (when self.current_card
    (print (string.format "Cardholder: %s" self.current_card.cardholder_name))
    (print (string.format "Total Amount: %s" self.current_card.balance))
    (print (string.format "Ounces Poured: %s" self.current_card.ounces_poured)))
  (print "\nEvents: ")
  (each [_ event (ipairs self.events)]
    (print event)))

(local card (Card :5555555555555555 "Ray Perry"))
(doto (Reader)
  (: :insert_card card)
  (: :charge_card 10.1 0.79)
  (: :remove_card)
  (: :insert_card card)
  (: :display_stats))
