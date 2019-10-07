(defclass card ()
  ((suit :accessor suit :initarg :suit)
    (value :accessor value :initarg :value)
    (color :accessor color :initarg :color))
  (:documentation "A single playing card."))

(defclass deck ()
  ((cards :accessor cards :initarg :cards))
  (:documentation "A pile of playing cards."))

(defun new-deck ()
  "Returns a new DECK of 52 CARDs."
  (make-instance 'deck
    :cards (loop for index from 1 to 52
             for (suit value) = (multiple-value-list (floor index 13))
             collect (make-instance 'card
                       :suit suit
                       :value value
                       :color (if (oddp suit) 'black 'red)))))

(defun shuffle-deck (deck)
  "Randomize the order of the CARDs in a DECK."
  (setf (cards deck)
    (sort (cards deck)
      (lambda (card1 card2)
        (declare (ignore card1 card2))
        (zerop (random 2)))))
  deck)

(defun top-cards (number-of-cards deck-of-cards)
  "Look at the top NUMBER-OF-CARDS in a DECK."
  (loop for index from 0 to (1- number-of-cards)
    collect (nth index (cards deck-of-cards))))
