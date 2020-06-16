(defmacro qw (&rest symbols)
  `(list ,@(mapcar (lambda (symbol) (format "%s" symbol)) symbols)))

(defmacro %% (number &rest divisors)
  (let ((results '()))
    (dolist (divisor divisors)
      (setq results (cons `(zerop (mod ,number ,divisor)) results)))
    `(and ,@(reverse results))))

(defmacro polymod (number &rest divisors)
  (let ((mutnum number)
         (results '()))
    (dolist (divisor divisors)
      (setq results (cons (mod mutnum divisor) results))
      (setq mutnum (/ mutnum divisor)))
    `(reverse (list ,mutnum ,@results))))

(defmacro letter-sequence (start end)
  (let ((results '()))
    (dolist (character (number-sequence (string-to-char start) (string-to-char end)))
      (unless (or (< character 65)
                (and (> character 90) (< character 97))
                (> character 122))
        (setq results (cons (char-to-string character) results))))
    `(list ,@(reverse results))))

;; ================================================================

(%% (car (polymod 2345 10 10 10)) 5)

;; ================================================================

(ert-deftest %%-tests ()
  "Tests the definition and usage of POLYMOD."
  (should (equal (%% 12 10) nil))
  (should (equal (%% 12 3) 't))
  (should (equal (%% 15 3 5) 't))
  (should (equal (%% 100 1 2 5 10) 't)))

(ert-deftest polymod-tests ()
  "Tests the definition and usage of POLYMOD."
  (should (equal (polymod 12) '(12)))
  (should (equal (polymod 12 10) '(2 1)))
  (should (equal (polymod 123 10 10) '(3 2 1)))
  (should (equal (polymod 64921 10 10 10 10) '(1 2 9 4 6))))

(ert-deftest letter-sequence-tests ()
  "Tests the definition and usage of LETTER-SEQUENCE."
  (should (equal (letter-sequence "a" "c") (qw a b c)))
  (should (equal (letter-sequence "A" "C") (qw A B C)))
  (should (equal (letter-sequence "s" "z") (qw s t u v w x y z)))
  (should (equal (letter-sequence "S" "Z") (qw S T U V W X Y Z))))
