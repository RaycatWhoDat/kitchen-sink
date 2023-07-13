(defvar names '("Karan" "Sean" "Isabel" "Lex" "Ray" "Solo"))
(each ((permutation (perm names (length names))))
  (each ((pair (partition permutation '(2 4))))
    (format t "~a and ~a\n" (car pair) (cadr pair))))

