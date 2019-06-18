(declaim (optimize (speed 3) (safety 3) (debug 3)))

(defun print-deck ()
  (loop for value to 51
    collect (cons (+ (mod value 13) 1) (nth (mod value 4) '(♥ ♦ ♠ ♣)))))
