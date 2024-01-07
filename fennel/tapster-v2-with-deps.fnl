(local Object (require :classic))

(local Card (Object:extend))
(fn Card.new [self number cardholder-name]
  (set self.number number)
  (set self.cardholder_name cardholder-name)
  (set self.balance 0.0)
  (set self.ounces_poured 0.0))

(local ReaderEvent (Object:extend))
(fn ReaderEvent.new [self event-type payload]
  (set self.event_type event-type)
  (set self.timestamp (os.date "%c"))
  (set self.payload payload))
