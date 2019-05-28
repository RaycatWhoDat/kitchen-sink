#!/usr/bin/env gsi-script

(define (get-files #!optional (current-directory "..") (traversal-level 0))
  "This recursively prints the files in CURRENT-DIRECTORY."
  (for-each (lambda (entry) (print (string-append (make-string (* 2 traversal-level) #\space) entry "\n"))
      (let ((printed-directory (string-append current-directory "/" entry)))
        (unless (member entry '(".git" "love" "target" "dist" ".dub" "node_modules"))
          (if (eq? (file-info-type (file-info printed-directory)) 'directory)
            (get-files printed-directory (+ traversal-level 1))))))
      (directory-files current-directory)))

(get-files)
