#lang racket

(define values `(A ,(range 2 10) J Q K))
(define suits '(♥ ♦ ♠ ♣))
(shuffle (for/list ([value (flatten values)]
            #:when (zero? (remainder (length suits) 4))
            [suit suits])
  (list value suit)))

;; Local Variables:
;; mode: Scheme
;; compile-command: "racket deck-of-cards.rkt"
;; End:
