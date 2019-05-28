(use-modules
  (ice-9 ftw)
  (ice-9 regex))

(define* (get-files #:key (directory-path ".."))
  "Iterates over DIRECTORY-PATH."
  (ftw directory-path
    (lambda (filename statinfo flag)
      (display filename)
      (newline)
      #t)))

(get-files)
