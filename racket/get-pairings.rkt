#lang scribble/text

@(require racket/random racket/list racket/set)

How about...
@(let* ((names '("Syd" "Sabrina" "Veronica" "Karan" "Sean" "Ray"))
       (all-combinations (combinations names 2))
       (pairs '()))
  (let loop ()
    (set! pairs (random-sample all-combinations 3))
    (when (not (subset? names (flatten pairs))) (loop)))
  (for/list ((pair pairs))
    (format "~a and ~a\n" (car pair) (cadr pair))))

;; (compile "racket get-pairings.rkt")
