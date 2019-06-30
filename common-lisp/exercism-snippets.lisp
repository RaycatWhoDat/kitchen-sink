(defpackage #:exercism
  (:use #:cl)
  (:export #:distance #:leap-year-p #:response-for))

(in-package #:exercism)

(defun distance (dna1 dna2)
  "Number of positional differences in two equal length dna strands."
  (when (= (length dna1) (length dna2))
    (loop for char1 across dna1
       for char2 across dna2
       count (char/= char1 char2))))

(defun leap-year-p (year)
  "Returns T if YEAR is a leap year."
  (zerop (mod year (if (zerop (mod year 100)) 400 4))))

(defun response-for (input)
  (let ((trimmed-input (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) input)))
    (if (zerop (length trimmed-input))
      "Fine. Be that way!"
      (let ((question? (char= (char trimmed-input (1- (length trimmed-input))) #\?)))
        (cond
          ((notany #'alpha-char-p trimmed-input) (if question? "Sure." "Whatever."))
          ((notany #'lower-case-p trimmed-input) (if question? "Calm down, I know what I'm doing!" "Whoa, chill out!"))
          (t (if question? "Sure." "Whatever.")))))))
