(defstruct card nil
  number
  cardholder-name
  (balance 0.0)
  (ounces-poured 0.0))

(defstruct reader-event nil
  event-type
  payload
  (timestamp (time)))

(defstruct reader nil
  current-card
  (events (vec))

  (:method insert-card (self card)
    (vec-push self.events (new reader-event event-type :inserted payload card.cardholder-name))
    (set self.current-card card))

  (:method remove-card (self)
    (vec-push self.events (new reader-event event-type :removed payload self.current-card.cardholder-name))
    (set self.current-card nil))

  (:method charge-card (self ounces-poured price-per-ounce)
    (when (not self.current-card) (return))
    (let ((charge (* ounces-poured price-per-ounce)))
      (vec-push self.events (new reader-event event-type :charged payload charge))
      (inc self.current-card.ounces-poured ounces-poured)
      (inc self.current-card.balance charge)))

  (:method display-stats (self)
    (unless (not self.current-card)
      (format t "Cardholder: ~a\n" self.current-card.cardholder-name)
      (format t "Total Amount: ~,2f\n" self.current-card.balance)
      (format t "Ounces Poured: ~,2f\n\n" self.current-card.ounces-poured))

    (format t "Events: \n")
    (each ((event self.events))
      (format t "~s - ~a - ~a\n" event.timestamp (upcase-str (symbol-name event.event-type)) event.payload))))

(defvar my-card (new card
                 number "5555555555555555"
                 cardholder-name "Ray Perry"))

(defvar my-reader (new reader))

my-reader.(insert-card my-card)
my-reader.(charge-card 10 0.5)
my-reader.(remove-card)
my-reader.(insert-card my-card)
my-reader.(display-stats)
