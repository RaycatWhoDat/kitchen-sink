#lang racket/base

(require racket/random)

(define *names* '(RaycatWhoDat Lythero EmyFails DickDebonair DNOpls DahMuttDog OverlordDyvone NosferatChew))
(define *blue* (random-sample *names* 4 #:replacement? #f))

(for ([blue *blue*]) (printf "Blue: ~a\n" blue))
(for ([gold (remove* *blue* *names*)]) (printf "Gold: ~a\n" gold))
