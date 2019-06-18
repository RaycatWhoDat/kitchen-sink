;; CARD

(defclass card ()
  ((value
     :initarg :value
     :accessor value)
    (suit
      :initarg :suit
      :accessor suit)))

(defun make-card (value suit)
  (make-instance 'card :value value :suit suit))

;; DECK

(defclass deck ()
  ((cards
     :initarg :cards
     :accessor cards)))

(defun make-deck (cards)
  (make-instance 'deck :cards cards))

(defgeneric shuffle (deck-of-cards)
  (:documentation "Returns DECK with CARDS in a randomized order.")
  (:method ((deck-of-cards deck))
    (setf (cards deck-of-cards)
      (sort (cards deck-of-cards)
        #'(lambda (card1 card2)
            (declare (ignore card1 card2))
            (zerop (random 2)))))))

(defgeneric look-at-top-card (deck-of-cards)
  (:documentation "Returns the value of top card of the DECK.")
  (:method ((deck-of-cards deck))
    (car (cards deck-of-cards))))

(defgeneric draw-card (deck-of-cards)
  (:documentation "Returns the top card of the DECK.")
  (:method ((deck-of-cards deck))
    (values (look-at-top-card deck-of-cards) (cdr (cards deck-of-cards)))))

(defgeneric remaining-cards (deck-of-cards)
  (:documentation "Returns the remaining number of CARDS in the DECK.")
  (:method ((deck-of-cards deck))
    (length (cards deck-of-cards))))

;;;
;;; TEST FUNCTIONS
;;;

(defun make-list-of-cards ()
  "Returns 52 CARD objects."
  (loop for index to 51
    for value = (+ (mod index 13) 1)
    for suit = (nth (mod value 4) '(♥ ♦ ♠ ♣))
    collect (make-card value suit)))
  
(let ((deck (make-deck (make-list-of-cards))))
  (shuffle deck)
  (loop repeat 5
    do (multiple-value-bind (drawn-card rest-of-cards) (draw-card deck)
         (declare (ignore drawn-card))
         (setf (cards deck) rest-of-cards)))
  (remaining-cards deck))
