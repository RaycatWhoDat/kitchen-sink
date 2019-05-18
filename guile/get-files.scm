(use-modules (ice-9 ftw))

(for-each (lambda (entry) (display entry) (newline)) (file-system-tree ".."))

(define* (get-files #:key (directory-path ".."))
  "Iterates over DIRECTORY-PATH."
  (display (string-append "I'll iterate over " directory-path " when implemented."))
  (newline))

(get-files)
