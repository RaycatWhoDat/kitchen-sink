(defun fibonacci (prev next)
  (lcons prev (fibonacci next (+ prev next))))

(print (take 10 (fibonacci 1 1)))
