#lang racket/base

(require racket/gui
         racket/gui/easy
         racket/gui/easy/operator)

(define @msg (@ "This is another test"))
(render
 (window
  #:title "This is a test"
  #:size '(480 360)
  (text @msg)
  (button "Click Me" (lambda () (@msg . := . "Button click")))))
