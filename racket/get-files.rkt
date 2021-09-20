#!/usr/bin/env racket

#lang racket

(define (get-files (directory-path "..") (traversal-level 0))
  (for ((entry (directory-list directory-path)))
    (let ((current-path (path->string entry)))
      (printf (string-append (make-string (* 2 traversal-level) #\space) "~a~%") current-path)
      (unless (for/or ((ignored-path '(".git" "love" "target" "dist" ".dub" "node_modules")))
                (string-contains? current-path ignored-path))
        (when (directory-exists? (path->directory-path (build-path directory-path current-path)))
          (get-files (string-append directory-path "/" current-path) (+ traversal-level 1)))))))

(if (vector-empty? (current-command-line-arguments))
    (get-files)
    (get-files (vector-ref (current-command-line-arguments) 0)))

;; Local Variables:
;; compile-command: "racket ./get-files.rkt"
;; End:
