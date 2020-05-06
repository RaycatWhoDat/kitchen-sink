(defun digital-cipher (input)
  "Given INPUT, which is a string of alphabetical characters,
calculate the appropriate response to the digital cipher puzzle
in KTaNE."
  (assert (stringp input) "Input must be a string.")

  (setf
    alphabet '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
    string1 (cdr (butlast (split-string input "")))
    string2 (reverse string1))

  (setf all-sums
    (loop
      for character1 in string1
      for character2 in string2
      collect (+ (1+ (seq-position alphabet character1)) (1+ (seq-position alphabet character2)))))

  (loop
    for number in all-sums
    collect (digital-root number)))

(defun digital-root (number)
  "Given a number, return the digital root."
  (assert (numberp number) "Number must be a number.")
  
  (let ((new-number 0))
    (setf new-number
      (loop
        for digit in (cdr (butlast (split-string (number-to-string number) "")))
        summing (string-to-number digit)))
    (if (> new-number 9)
      (digital-root new-number)
      new-number)))

(digital-cipher "mefipzgwqwvctlz")
