(defun throw-dice ()
  "Randomly generates a list of numbers."
  (cons (1+ (random 6)) (1+ (random 6))))

(defun instant-win-p (&optional roll) t)
(defun instant-loss-p (&optional roll) t)

(defun play-craps (roll)
  "Returns a result based on ROLL."
  (destructuring-bind (die1 . die2) roll
    (format t "THROW ~A AND ~A -- ~A~%"
      die1 die2
      (cond ((instant-win-p roll) "YOU WIN")
        ((instant-loss-p roll) "YOU LOSE")
        (t (format t "YOUR POINT IS ~A"
             (write-to-string (+ die1 die2))))))))

(play-craps (throw-dice))
