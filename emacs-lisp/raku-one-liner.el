(defun raku-one-liner (expression)
  (interactive "sRaku expression: ")
  (shell-command (format "raku -e \"%s\"" expression)))
