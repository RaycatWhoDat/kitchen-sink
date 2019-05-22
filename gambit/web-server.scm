#!/usr/bin/env gxi

(import :std/net/httpd :std/xml)

(define httpd
  (start-http-server! "127.0.0.1:6789"))

(define (hello-handler req res)
  (http-response-write
    res
    200
    '(("Content-Type" . "text/plain"))
    "This is a web page created with Gambit/Gerbil Scheme.\n"))

(http-register-handler httpd "/hello" hello-handler)
