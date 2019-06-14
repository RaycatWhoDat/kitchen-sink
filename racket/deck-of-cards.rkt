#lang racket

(define suits '(♥ ♦ ♠ ♣))
(define deck-of-cards
  (for/list ([value (range 1 14)]
             #:when (zero? (remainder (length suits) 4))
             [suit suits])
    (cons value suit)))

(define (show-hand cards-in-hand)
  "Print each card in CARDS-IN-HAND."
  (for-each
    (lambda (card)
      (let ([value (car card)]
             [suit (symbol->string (cdr card))])
        (print
          (format "~a~a"
            (cond [(= value 1) "A"]
              [(= value 11) "J"]
              [(= value 12) "Q"]
              [(= value 13) "K"]
              [else value])
            suit))))
    cards-in-hand))

(show-hand (take (shuffle deck-of-cards) 5))

;; Local Variables:
;; mode: Scheme
;; compile-command: "racket deck-of-cards.rkt"
;; End:
