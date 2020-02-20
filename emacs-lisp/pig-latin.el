(require 'cl)
(require 'subr)

(defun pig-it (input)
  "Given INPUT is a space-separated string, return the pig latin version of it."
  (assert (stringp input))
  (loop for word in (split-string input " ")
    collect (concat (substring word 1) (substring word 0 1) (if (> (length word) 1) "ay")) into words
    finally (return (string-join words " "))))

;; pigIt('Pig latin is cool') ;; igPay atinlay siay oolcay
;; pigIt('Hello world !') ;; elloHay orldway !
