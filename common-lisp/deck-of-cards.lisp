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
    :cards (loop for index from 1 to 52
             for (suit-value face-value) = (multiple-value-list (floor index 13))
             for (color suit) = (nth suit-value '((red ♥) (black ♠) (red ♦) (black ♣)))
             collect (make-instance 'card
                       :value (if (= face-value 0) 13 face-value)
                       :suit (if suit suit '♣)
                       :color (if color color 'black)))))

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

(defgeneric separate-cards-by-color (deck-of-cards)
  (:documentation "Returns two lists of cards, separated by COLOR.")
  (:method (deck-of-cards)
    (loop for card in (cards deck-of-cards)
      if (equal (color card) 'black)
      collect card into black-cards
      else collect card into red-cards
      finally (return (values black-cards red-cards)))))

;; HAND

(defclass hand-of-cards (deck-of-cards) ())

(defun make-hand-of-cards (deck)
  (make-instance 'hand-of-cards :cards (loop repeat 5 collect (draw-card deck))))

(defgeneric show-cards-in-hand (hand-of-cards)
  (:documentation "Returns the pretty-printed version of the CARDS in HAND-OF-CARDS.")
  (:method (hand-of-cards)
    (dolist (card (cards hand-of-cards))
      (format t "~a~a~%" (pretty-print-value card) (suit card)))))

;;;
;;; TEST FUNCTIONS
;;;

;; (let ((deck (shuffle (make-deck-of-cards))))
;;   (loop repeat 5 do (draw-card deck))
;;   (remaining-cards deck))
