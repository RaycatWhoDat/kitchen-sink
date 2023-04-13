(defn make-inventory-item
  "Creates an new inventory item."
  [id name price]
  {
   :id id
   :name name
   :price price
  })

(defn make-store-event
  "Creates an new store event."
  [event-type payload]
  {
   :event-type event-type
   :timestamp (os/time)
   :payload payload
  })

(defn make-store
  "Creates a new store."
  [name]
  {
   :name name
   :opening-time 900
   :closing-time 1700
   :stock @{}
   :events @[]
   :update-item-quantity (fn [self item amount] (put (self :stock) (item :id) amount))
   :purchase-item (fn [self item]
                    (when (> ((self :stock) (item :id)) 0)
                      (:update-item-quantity self item (- ((self :stock) (item :id)) 1))))
   :refund-item (fn [self item]
                  (:update-item-quantity self item (+ ((self :stock) (item :id)) 1)))
  })

(def item1 (make-inventory-item "1" "Item 1 - A" 500))
(def item2 (make-inventory-item "2" "Item 2 - B" 750))
(def item3 (make-inventory-item "3" "Item 3 - C" 1000))

(def store (make-store "Bob's Shop"))

(:update-item-quantity store item1 10)
(:update-item-quantity store item2 7)
(:update-item-quantity store item3 5)

(:purchase-item store item1)

(eachp [key value] (store :stock) (print key ": " value))
