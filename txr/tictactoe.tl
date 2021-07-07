(defvar *naught-or-cross* '("o" "x"))
(defvar *board* (rlist 1..9))
(defvar *winning-positions* ^(,(rlist 0..2) ,(rlist 3..5) ,(rlist 6..8) (0 3 6) (1 4 7) (2 5 8) (0 4 8) (2 4 6)))

(defun pick (iterable) [iterable (rand (length iterable) (make-random-state))])

(defun get-winner ()
  (each ((winning-position *winning-positions*))
    (when (all [*board* winning-position] (op equal (car [*board* winning-position])))
      (return (list [*board* winning-position] (mapcar (op + 1) winning-position))))))

(defun free-indexes () (keep-if (op in-range 1..9) *board*))

(defun human-move ()
  (let ((answer nil))
    (until answer
      (format t "Choose one of ~a: \n" (cat-str (mapcar 'tostring (free-indexes)) ", "))
      (let ((possible-answer (int-str (get-line))))
        (when (member possible-answer (free-indexes))
          (set answer possible-answer))))
    (format t "You move to ~a.\n" answer)
    (set (nth (- answer 1) *board*) [*naught-or-cross* 1])))

(defun cpu-move ()
  (let ((index (pick (free-indexes))))
    (set (nth (- index 1) *board*) [*naught-or-cross* 0])
    (format t "Moving to ~a.\n" index)))

(defun print-board ()
  (pprinl (cat-str
            (mapcar
              (op format nil "~a | ~a | ~a\n" . @1)
              (partition *board* (where (lambda (index) (zerop (mod index 3))) 0..8)))
            "--+---+--\n")))
  
(until (or (get-winner) (empty (free-indexes)))
  (print-board)
  (human-move)
  (cpu-move))

(match-case (get-winner)
  ((@player @winningPosition) (format t "~a wins across ~a.\n" [player 0] winningPosition))
  (nil (format t "How boring, a draw!.\n")))
  
