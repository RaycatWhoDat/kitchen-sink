#lang racket/base

(require racket/gui)

(define frame
  (new frame%
       [label "This is a test"]
       [width 480]
       [height 360]))

(define msg
  (new message%
     [parent frame]
     [label "This is another test"]))

(new button% [parent frame]
             [label "Click Me"]
             [callback (lambda (button event)
                         (send msg set-label "Button click"))])

(send frame show #t)
