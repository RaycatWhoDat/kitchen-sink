(defmacro qs (&rest symbols)
  "Shorthand for making a list of strings."
  `(list ,@(mapcar (lambda (symbol) (format "%s" symbol)) symbols)))

(defun polymod (base &rest mods)
  "Given a BASE which is a number, return a list of places based
on MODS."
  (let ((mutable-base base))
    (loop
      for divisor in mods
      collect (mod mutable-base divisor) into results
      and do (setq mutable-base (/ mutable-base divisor))
      finally (return (nconc results (list mutable-base))))))

(defun letter-sequence (start end)
  (loop
    for character in (number-sequence (string-to-char start) (string-to-char end))
    unless (or (< character 65)
             (and (> character 90) (< character 97))
             (> character 122))
    collect (char-to-string character)))

(ert-deftest polymod-tests ()
  "Tests the definition and usage of POLYMOD."
  (should (equal (polymod 12) '(12)))
  (should (equal (polymod 12 10) '(2 1)))
  (should (equal (polymod 123 10 10) '(3 2 1)))
  (should (equal (polymod 64921 10 10 10 10) '(1 2 9 4 6))))

(ert-deftest letter-sequence-tests ()
  "Tests the definition and usage of LETTER-SEQUENCE."
  (should (equal (letter-sequence "a" "c") (qs a b c)))
  (should (equal (letter-sequence "A" "C") (qs A B C)))
  (should (equal (letter-sequence "s" "z") (qs s t u v w x y z)))
  (should (equal (letter-sequence "S" "Z") (qs S T U V W X Y Z))))
  
