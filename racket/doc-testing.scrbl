#lang scribble/text

@(require csv-reading)
@(require racket/match)
@(define *csv-lines* (cdr (csv->list (open-input-file "../d/MOCK_DATA.csv"))))
@(define *entry-format* #<<ENTRY
First Name: ~a
Last Name: ~a
Email: ~a
Date of Birth: ~a


ENTRY
)

@(for/list ([row *csv-lines*])
   (match-let ([(list first-name last-name email dob) row])
     (format *entry-format* first-name last-name email dob)))