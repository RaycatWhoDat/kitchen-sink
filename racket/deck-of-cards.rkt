#lang racket

(define deck-of-cards
  (for/list ([value (range 52)])
    (list (+ (remainder value 13) 1)
          (list-ref '(♥ ♦ ♠ ♣) (floor (/ value 13))))))

(define (show-hand cards-in-hand)
  "Print each card in CARDS-IN-HAND."
  (for-each
    (lambda (card)
      (let ([value (first card)]
             [suit (symbol->string (last card))])
        (print
          (format "~a~a"
            (match value
              [1 "A"]
              [11 "J"]
              [12 "Q"]
              [13 "K"]
              [_ value])
            suit))))
    cards-in-hand))

(show-hand (take (shuffle deck-of-cards) 5))

;; Local Variables:
;; mode: Scheme
;; compile-command: "racket deck-of-cards.rkt"
;; End:
