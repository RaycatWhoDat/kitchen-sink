(import
  (chicken file)
  (chicken file posix)
  (chicken platform)
  (chicken process-context)
  (chicken string)
  getopt-long
  srfi-1
  loop)

(define *two-spaces* 2)
(define *is-recursive* #f)
(define *root-directory* ".")
(define *indentation-character* #\space)
(define *ignored-paths* '(".git" "node_modules" "dist" "love"))
(define *path-separator* (if (equal? (software-type) 'windows) "\\" "/"))

(define (print-files directory-path #!optional (traversal-level 0))
  "Given a DIRECTORY-PATH, list the files in the directory. Based on
TRAVERSAL-LEVEL, add a number of indentation characters."
  (loop for file-path in (find-files directory-path limit: 0)
    for formatted-name = (last (string-split file-path *path-separator*))
    do (print (conc
                (make-string (* *two-spaces* traversal-level) *indentation-character*)
                formatted-name))
    when (directory? file-path)
    unless (or (member formatted-name *ignored-paths*) (not *is-recursive*))
    do (print-files file-path (+ traversal-level 1))))

(let* ((arguments
         (getopt-long
           (command-line-arguments)
           `((directory
               (single-char #\d)
               (value #t))
              (recursive
                (single-char #\r)
                (value #f)))))
        (directory-arg (alist-ref 'directory arguments))
        (recursive-arg (alist-ref 'recursive arguments)))
  (set! *root-directory* (or directory-arg *root-directory*))
  (set! *is-recursive* (or recursive-arg *is-recursive*))
  (print-files *root-directory*))
        

;; Local Variables:
;; compile-command: "csi -s ./get-files.scm -d .."
;; End:
