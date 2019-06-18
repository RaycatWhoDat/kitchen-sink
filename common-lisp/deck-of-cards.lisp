(defun print-deck ()
  (declare (optimize (speed 3) (safety 0) (debug 0) (compilation-speed 3)))
  (loop for index to 51
    for value = (+ (mod index 13) 1)
    for suit = (nth (mod value 4) '(♥ ♦ ♠ ♣))
    collect (cons value suit)))
