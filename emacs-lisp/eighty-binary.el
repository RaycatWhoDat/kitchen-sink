;; ("01010101" "11010010" "10101010")

(defun convert-to-bools (sequences)
  "Given SEQUENCES is a list of eight-character strings, it
  returns a list of lists containing t or nil for each 1 and 0
  respectively."
  (loop for sequence in sequences
    collect (loop for character across sequence
              collect (if (char-equal character 49) t nil))))

(convert-to-bools '("01010101" "11010010" "10101010"))
