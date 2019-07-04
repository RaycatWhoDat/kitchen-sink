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

(defun question-p (statement) (char= (char statement (1- (length statement))) #\?))
(defun shouting-p (statement) (and (notany #'lower-case-p statement) (some #'alpha-char-p statement)))
(defun silence-p (statement) (zerop (length statement)))

(defun response-for (input)
  (let ((statement (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) input)))
    (cond
      ((silence-p statement) "Fine. Be that way!")
      ((and (shouting-p statement) (question-p statement)) "Calm down, I know what I'm doing!")
      ((shouting-p statement) "Whoa, chill out!")
      ((question-p statement) "Sure.")
      (t "Whatever."))))
