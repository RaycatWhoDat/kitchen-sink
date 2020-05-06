(defun number-of-rounds (participants)
  "Given PARTICIPANTS is a number, list the number of rounds
required."
  (assert (= (mod participants 2) 0) nil "PARTICIPANTS must be an even number.")
  (let ((rounds nil))
    (while (> participants 1)
      (setf rounds (cons participants rounds))
      (setf participants (/ participants 2)))
    (length rounds)))

(number-of-rounds 32)
