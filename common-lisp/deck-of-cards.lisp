;; CARD

(defclass card ()
  ((value
     :initarg :value
     :accessor value)
    (suit
      :initarg :suit
      :accessor suit)
    (color
     :initarg :color
     :accessor color)))

(defgeneric pretty-print-value (card)
  (:documentation "Returns the display value of the given CARD.")
  (:method (card)
    (let ((raw-value (value card)))
      (cond ((= raw-value 1) 'A)
        ((= raw-value 11) 'J)
        ((= raw-value 12) 'Q)
        ((= raw-value 13) 'K)
        (t raw-value)))))

;; DECK

(defclass deck-of-cards ()
  ((cards
     :initarg :cards
     :accessor cards)))

(defun make-deck-of-cards ()
  (make-instance 'deck-of-cards
    :cards (loop for index to 51
             for value = (+ (mod index 13) 1)
             for suit = (nth (mod value 4) '(♥ ♠ ♦ ♣))
             for color = (nth (mod value 2) '(red black))
             collect (make-instance 'card :value value :suit suit :color color))))

(defgeneric shuffle (deck-of-cards)
  (:documentation "Returns DECK with CARDS in a randomized order.")
  (:method (deck-of-cards)
    (setf (cards deck-of-cards)
      (sort (cards deck-of-cards)
        (lambda (card1 card2)
            (declare (ignore card1 card2))
            (zerop (random 2)))))
    deck-of-cards))

(defgeneric look-at-top-card (deck-of-cards)
  (:documentation "Returns the value of top card of the DECK.")
  (:method (deck-of-cards)
    (car (cards deck-of-cards))))

(defgeneric draw-card (deck-of-cards)
  (:documentation "Returns the top card of the DECK.")
  (:method (deck-of-cards)
    (let ((drawn-card (look-at-top-card deck-of-cards))
          (rest-of-cards (cdr (cards deck-of-cards))))
      (setf (cards deck-of-cards) rest-of-cards)
      drawn-card)))

(defgeneric remaining-cards (deck-of-cards)
  (:documentation "Returns the remaining number of CARDS in the DECK.")
  (:method (deck-of-cards)
    (length (cards deck-of-cards))))

;;;
;;; TEST FUNCTIONS
;;;

;; (let ((deck (shuffle (make-deck-of-cards))))
;;   (loop repeat 5 do (draw-card deck))
;;   (remaining-cards deck))

;; TODO: Fix the card generation.

(loop for card in (cards (shuffle (make-deck-of-cards)))
  if (equal (color card) 'black)
  collect card into black-cards
  and count t into number-of-black-cards
  else collect card into red-cards
  and count t into number-of-red-cards
  finally (return (values number-of-black-cards black-cards number-of-red-cards red-cards)))

