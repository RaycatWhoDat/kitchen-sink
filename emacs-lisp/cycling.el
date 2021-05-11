(require 'dash)

(setq
  numbers (number-sequence 1 5)
  fruits '("Apple" "Banana" "Cherry" "Date" "Fig"))

(defun print-item (item)
  (insert (format "%s\n" item)))

(-each (-take 20 (-cycle numbers)) 'print-item)
(-each (-take 20 (-cycle fruits)) 'print-item)

(-each
  (-take 20 (-cycle (-zip fruits numbers)))
  (lambda (item) (insert (format "%s: %s\n" (car item) (cdr item)))))
