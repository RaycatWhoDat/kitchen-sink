(defmacro qw (&rest symbols)
  "Returns a quoted list of strings."
  `(list ,@(mapcar (lambda (symbol) (format "%s" symbol)) symbols)))

(defmacro %% (number &rest divisors)
  "Returns T or NIL if NUMBER is evenly divisible by all DIVISORS."
  `(and ,@(mapcar (lambda (divisor) `(zerop (mod ,number ,divisor))) divisors)))

(defmacro between (number min max)
  "Returns T or NIL if NUMBER is between MIN and MAX, inclusive."
  `(and (>= ,number ,min) (<= ,number ,max)))

(defmacro polymod (number &rest divisors)
  "Returns a list of modulo results with the remainder as the first element."
  (let ((mutnum number)
         (results '()))
    (dolist (divisor divisors)
      (setq results (cons (mod mutnum divisor) results))
      (setq mutnum (/ mutnum divisor)))
    `(reverse (list ,mutnum ,@results))))

(defmacro letter-sequence (start end)
  "Returns a list of quoted letters."
  `(mapcar
     'char-to-string
     (remove-if-not
       (lambda (character) (or (between character 65 90) (between character 97 122)))
       (number-sequence (string-to-char ,start) (string-to-char ,end)))))

(defun is-pangram (input-string)
  "Returns T or NIL based on the existence of the each letter in the string."
  (let ((characters
          (sort (delete-dups (split-string (downcase input-string) "" t)) 'string<)))
    (null (remove-if
            (lambda (fragment) (member fragment characters))
            (cons " " (letter-sequence "a" "z"))))))

;; ================================================================

;; ================================================================

(ert-deftest qw-tests ()
  "Tests the definition and usage of qw."
  (should (equal (qw 12 10) '("12" "10")))
  (should (equal (qw a b c d) '("a" "b" "c" "d")))
  (should (equal (qw This is a test) '("This" "is" "a" "test")))
  (should (equal
            (qw The quick brown fox jumps over the lazy dog)
            '("The" "quick" "brown" "fox" "jumps" "over" "the" "lazy" "dog"))))

(ert-deftest %%-tests ()
  "Tests the definition and usage of %%."
  (should (equal (%% 12 10) nil))
  (should (equal (%% 12 3) 't))
  (should (equal (%% 15 3 5) 't))
  (should (equal (%% 100 1 2 5 10) 't)))

(ert-deftest between-tests ()
  "Tests the definition and usage of BETWEEN."
  (should (equal (between 12 10 14) 't))
  (should (equal (between 1832 10 14) nil))
  (should (equal (between 13802 13479 13802) 't))
  (should (equal (between 1 1 10) 't)))

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

(ert-deftest is-pangram-tests ()
  "Tests the definition and usage of IS-PANGRAM."
  (should (equal (is-pangram "stroop") nil))
  (should (equal (is-pangram "strooafbnsdhfobuofwerbogb") nil))
  (should (equal (is-pangram "The quick brown fox jumps over the lazy dog") t)))
