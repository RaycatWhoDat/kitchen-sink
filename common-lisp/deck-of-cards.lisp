(defun make-deck ()
  "Returns a fresh DECK of cards."
  (loop for index to 51
    for value = (+ (mod index 13) 1)
    for suit = (nth (mod value 4) '(♥ ♦ ♠ ♣))
    collect (cons value suit)))

(defun shuffle (deck)
  "Returns DECK in a randomized order."
  (sort deck #'(lambda (card1 card2)
                 (declare (ignore card1 card2))
                 (zerop (random 2)))))

(defun look-at-top-card (deck)
  "Returns the value of top card of the DECK."
  (car deck))

(defun draw-card (deck)
  "Returns the top card of the DECK."
  (values (look-at-top-card deck) (cdr deck)))

(let ((deck (shuffle (make-deck))))
  (loop repeat 5
    do (multiple-value-bind (drawn-card rest-of-cards) (draw-card deck)
         (declare (ignore drawn-card))
         (setf deck rest-of-cards)))
  (length deck))
