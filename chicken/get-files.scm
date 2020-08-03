(import
  (only (chicken file) find-files)
  (only (chicken file posix) directory?)
  (only (chicken platform) software-type)
  (only (chicken process-context) command-line-arguments)
  (only (chicken sort) sort)
  (only (chicken string) string-split conc)
  (only srfi-1 last)
  (only srfi-13 string< string-upcase)
  getopt-long
  loop)

(define *two-spaces* 2)
(define *is-recursive* #f)
(define *indentation-character* #\space)
(define *ignored-paths* '(".git" "node_modules" "dist" "love"))
(define *path-separator* (if (equal? (software-type) 'windows) "\\" "/"))

(define (print-files #!optional (directory-path ".") (traversal-level 0))
  "Given a DIRECTORY-PATH, list the files in the directory. Based on
TRAVERSAL-LEVEL, add a number of indentation characters."
  (loop
    for file-path in (sort (find-files directory-path limit: 0)
                       (lambda (lhs rhs) (string< (string-upcase lhs) (string-upcase rhs))))
    for formatted-name = (last (string-split file-path *path-separator*))
    do (print (conc
                (make-string (* *two-spaces* traversal-level) *indentation-character*)
                formatted-name))
    when (directory? file-path)
    unless (or (member formatted-name *ignored-paths*) (not *is-recursive*))
    do (print-files file-path (+ traversal-level 1))))

(let* ((arguments (getopt-long
                    (command-line-arguments)
                    `((directory
                        (single-char #\d)
                        (value #t))
                       (recursive
                         (single-char #\r)
                         (value #f)))))
        (directory-arg (alist-ref 'directory arguments))
        (recursive-arg (alist-ref 'recursive arguments)))
  (set! *is-recursive* (or recursive-arg *is-recursive*))
  (if directory-arg
    (print-files directory-arg)
    (print-files)))
        
;; Local Variables:
;; compile-command: "csi -s ./get-files.scm -d .."
;; End:
