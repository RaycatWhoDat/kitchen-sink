(defstruct inventory-item () id name price)
(defstruct store-event () event-type (timestamp (time)) payload)
(defstruct store ()
  name
  (opening-time 900)
  (closing-time 1700)
  (stock (hash))
  (events (vec))

  (:method update-item-quantity (self item amount)
    (sethash self.stock item.id amount))
  
  (:method purchase-item (self item)
    (vec-push self.events (new store-event event-type :purchased payload item.id))
    self.(update-item-quantity item (dec (gethash self.stock item.id))))

  (:method refund-item (self item)
    (vec-push self.events (new store-event event-type :refunded payload item.id))
    self.(update-item-quantity item (inc (gethash self.stock item.id)))))

(defvar item1 (new inventory-item id "1" name "Item 1 - A" price 500))
(defvar item2 (new inventory-item id "2" name "Item 2 - B" price 750))
(defvar item3 (new inventory-item id "3" name "Item 3 - C" price 1000))

(defvar my-store (new store name "Bob's Shop"))

my-store.(update-item-quantity item1 10)
my-store.(update-item-quantity item2 7)
my-store.(update-item-quantity item3 5)

my-store.(purchase-item item1)

(prinl my-store.stock)
