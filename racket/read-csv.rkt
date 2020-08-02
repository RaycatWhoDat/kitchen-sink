#lang racket

(require csv-reading)

(csv-for-each
 (lambda (row)
   (for ([index (in-range (length row))]
         [column row])
     (printf "~a" column)
     (if (= index (- (length row) 1))
         (newline)
         (display ", "))))
 (open-input-file "MOCK_DATA.csv"))
