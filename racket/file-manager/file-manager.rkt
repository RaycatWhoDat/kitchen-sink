#lang racket/gui

(require racket/file)

;; Start at the present working directory
(define *current-directory* "/")
(define *ignored-paths* '("." ".." ".git" "node_modules" ".dub" "love" "target" "dist"))

;; Get a list of all the files in the directory
(define (do-files (directory-path *current-directory*))
  (map
   path->string
   (filter
    (lambda (file-path) (not (member (path->string file-path) *ignored-paths*)))
    (directory-list directory-path))))

(define (dclick-handler list-box event)
  (when (eq? (send event get-event-type) 'list-box-dclick)
    (let* ((target (list-ref *current-listing* (car (send list-box get-selections))))
           (new-directory (path->string (build-path *current-directory* target))))
      (when (directory-exists? new-directory)
        (set! *current-directory* new-directory)
        (set! *current-listing* (do-files))
        (send list-box set *current-listing*))
      (when (not (directory-exists? new-directory))
        (print new-directory)))))

;; Define the top-level frame
(define top-frame
  (new frame%
       [label "File Manager"]
       [width 480]
       [height 360]))

(define *current-listing* (do-files))

(define list-box
  (new list-box%
       [label ""]
       [parent top-frame]
       [choices *current-listing*]
       [style (list 'single)]
       [callback dclick-handler]))

;; Display frame
(send top-frame show #t)
