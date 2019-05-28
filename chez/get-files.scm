;; #!/usr/bin/env chez --script

(define (get-files directory-path traversal-level)
  (for-each (lambda (entry)
              (display (string-append (make-string (* 2 traversal-level) #\space) entry "\n"))
              (let ((printed-directory (string-append directory-path "/" entry)))
                (unless (member entry '(".git" "love" "target" "dist" ".dub" "node_modules"))
                  (when (file-directory? printed-directory)
                    (get-files printed-directory (+ traversal-level 1))))))
    (directory-list directory-path)))

(get-files ".." 0)
