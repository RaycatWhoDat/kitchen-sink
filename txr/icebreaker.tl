(let ((questions (file-get-lines "./icebreaker.txt")))
  (pprinl (nth (rand (length questions) (make-random-state)) questions)))
