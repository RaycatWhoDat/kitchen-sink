(require 'cl-lib)

(defun slurp (file-path)
  "Reads the file located at FILE-PATH and returns a list of lines."
  (cl-assert (file-readable-p file-path) t "FILE-PATH is not a valid file.")
  (with-temp-buffer
    (insert-file-contents file-path)
    (split-string (buffer-string) "\n")))

(with-temp-file "final_conversion.csv"
  (cl-loop
    for number in (slurp "formatted_numbers.txt")
    for text in (slurp "formatted_text.txt")
    for type in (slurp "formatted_types.txt")
    do (insert (format "%s,%s,%s\n" number text type))))
