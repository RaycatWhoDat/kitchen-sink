#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer define-quick-math (ffi-lib "../txr/quick-math/target/debug/libquick_math"))

(define-quick-math add (_fun _float _float -> _float))
(define-quick-math subtract (_fun _float _float -> _float))
(define-quick-math multiply (_fun _float _float -> _float))
(define-quick-math divide (_fun _float _float -> _float))

(print (divide (subtract (multiply (add 1.0 2.0) 3.0) 1.0) 2.0))
 
