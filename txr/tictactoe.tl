(defvar *naught-or-cross* '("O" "X"))

(defstruct square nil (value ""))

(defvar *board* (repeat (list (new square value (car *naught-or-cross*))) 9))

(defvar *board-string* "~a | ~a | ~a\n--+---+--\n~a | ~a | ~a\n--+---+--\n~a | ~a | ~a")

(apply 'format t *board-string* (mapcar (lambda (square) square.value) *board*))
