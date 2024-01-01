(def Card
  @{
    :number ""
    :cardholder-name ""
    :balance 0.0
    :ounces-poured 0.0
   })

(defn make-card [number cardholder-name]
  (table/setproto @{ :number number :cardholder-name cardholder-name } Card))

(def ReaderEvent
  @{
    :event-type ""
    :timestamp (os/time)
    :payload ""
   })

(defn make-reader-event [event-type payload]
  (table/setproto @{ :event-type event-type :payload payload } ReaderEvent))

(def Reader
  @{
    :current-card nil
    :events @[]
    :insert-card
      (fn [self card]
        (array/push (get self :events) (make-reader-event "INSERTED" (get card :cardholder-name)))
        (put self :current-card card))
    :remove-card
      (fn [self]
        (array/push (get self :events) (make-reader-event "REMOVED" (get-in self [:current-card :cardholder-name])))
        (put self :current-card nil))
    :charge-card
      (fn [self ounces-poured price-per-ounce]
        (unless (nil? (get self :current-card))
          (def charge (* ounces-poured price-per-ounce))
          (array/push (get self :events) (make-reader-event "CHARGED" charge))
          (put-in self [:current-card :ounces-poured] ounces-poured)
          (put-in self [:current-card :balance] charge)))
    :display-stats
      (fn [self]
        (when (get self :current-card)
          (printf "Cardholder: %s" (get-in self [:current-card :cardholder-name]))
          (printf "Total Amount: $%.2f" (get-in self [:current-card :balance]))
          (printf "Ounces Poured: %.2f" (get-in self [:current-card :ounces-poured])))
        (print "\nEvents:")
        (each event (get self :events)
            (print (string (get event :timestamp) " - " (get event :event-type) " - " (get event :payload)))))
    })
        
(defn make-reader []
  (table/setproto @{} Reader))

(defn main [& args]
  (def my-card (make-card "5555555555555555" "Ray Perry"))
  (def my-reader (make-reader))
  
  (:insert-card my-reader my-card)
  (:charge-card my-reader 10.1 0.79)
  (:display-stats my-reader)
  (:remove-card my-reader))
