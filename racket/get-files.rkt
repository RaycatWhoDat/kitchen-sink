#lang racket/base

(require racket/path racket/string)

(define (get-files directory-path)
  (parameterize ([current-directory directory-path])
    (for ([entry (in-directory)])
      (unless (for/or ([ignored-path '(".git/" "love/" "target/" "dist/" ".dub/" "node_modules")])
                (string-contains? (path->string entry) ignored-path))
        (printf "~a\n" (file-name-from-path entry))))))

(get-files "..")

