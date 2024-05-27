#lang racket/base

(require racket/class
         racket/pretty)

(define card%
  (class object%
    (super-new)
    (init-field number cardholder-name [balance 0.00] [ounces-poured 0.00])))

(define reader-event%
  (class object%
    (super-new)
    (init-field event-type payload [timestamp null])))

(define reader%
  (class object%
    (super-new)
    (init-field [current-card null] [events '()])

    (define/public (insert-card card)
      (set! events
            (append events (list (new reader-event% [event-type 'inserted] [payload (get-field cardholder-name card)]))))
      (set! current-card card))

    (define/public (charge-card ounces-poured price-per-ounce)
      (let ((charge (* ounces-poured price-per-ounce)))
        (set! events (append events (list (new reader-event% [event-type 'charged] [payload (number->string charge)]))))
        (set-field! ounces-poured current-card (+ (get-field ounces-poured current-card) ounces-poured))
        (set-field! balance current-card (+ (get-field balance current-card) charge))))
    
    (define/public (remove-card)
      (set! events
            (append events (list (new reader-event% [event-type 'removed] [payload (get-field cardholder-name current-card)]))))
      (set! current-card null))))

(define my-card (new card% [number "5555555555555555"] [cardholder-name "Ray Perry"]))
(define my-reader (new reader%))

(send my-reader insert-card my-card)
(send my-reader charge-card 10.3 0.79)
(send my-reader remove-card)
