;;; odin-utils.el

(defun clean-up-bin-files ()
  "Deletes all .bin files in the current directory."
  (interactive)
  (loop
    for bin-filename
    in (-filter
         (lambda (filename) (s-matches? "\\.bin$" filename))
         (directory-files default-directory))
    do (delete-file bin-filename)))
