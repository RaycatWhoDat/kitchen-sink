(defun convert-to-bools (sequences)
  "Given SEQUENCES is a list of eight-character strings, it
  returns a list of lists containing t or nil for each 1 and 0
  respectively."

  (dolist (sequence sequences)
    (when (not (= (length sequence) 8))
      (error "All sequences must be eight characters in length")))

  (loop for character across (apply #'concat sequences)
    collect (if (char-equal character 49) t nil) into chunk
    when (= (length chunk) 8)
    collect chunk and do (setq chunk nil)))

(convert-to-bools '("01010101" "11010010" "10101010" "1"))
