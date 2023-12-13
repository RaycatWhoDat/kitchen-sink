(local pp (-> (require :utils) (. :pp)))

(local Class {})
(fn Class.new [new-self new-obj]
  (tset new-self :__index new-self)
  (setmetatable new-obj new-self))

(local Card {})
(fn Card.new [self cardholder-name number]
  (Class.new self { :number number
                    :cardholder_name cardholder-name
                    :balance 0
                    :ounces_poured 0 }))

(local ReaderEvent {})
(fn ReaderEvent.new [self event-type payload]
  (Class.new
    self
    { :event_type event-type
      :timestamp (os.date "%c")
      :payload payload }))
                    



(pp (: Card :new "Ray Perry" "5555555555555555"))
  

