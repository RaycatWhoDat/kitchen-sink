(defvar *test-case* (range 1 5))

(match-case *test-case*
  ((@a @b . @rest) (format t "~a is not ~a and is not ~a." a b rest)))
