#!/usr/bin/env racket

#lang racket

(require web-server/servlet web-server/servlet-env)

(define (test-page req)
  (response/xexpr
    `(html
       (head
         (title "Test Page"))
       (body
         (h1 "Hello!")
         (h4 "This is a web page created in Racket.")))))

(serve/servlet test-page)
