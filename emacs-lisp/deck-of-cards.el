(defun print-deck ()
  "Prints out a deck of cards."
  (loop for index to 51
    for value = (+ (mod index 13) 1)
    for suit = (nth (mod value 4) '(♥ ♦ ♠ ♣))
    collect (cons value suit)))

(debug-on-entry 'print-deck)

(print-deck)
