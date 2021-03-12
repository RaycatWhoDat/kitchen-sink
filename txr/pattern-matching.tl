(defvar *test-case* (range 1 3))

(match-case *test-case*
  ((@a @b @c) (format t "~a is not ~a and is not ~a." a b c)))
