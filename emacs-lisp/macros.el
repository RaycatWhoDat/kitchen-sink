(defun ++ (&rest args)
  "Add numbers together."
  (dolist (arg $args)
    (when (not (numberp arg))
      (error (format "Expected ARGS to exclusively contain numbers, got: %s" arg))))
  (apply '+ args))

(defun range (begin &optional end)
  "Returns a range included between BEGIN and END. If only BEGIN is specified, return a range, starting at 1 and ending at BEGIN, inclusively."
  (when (not (numberp begin)) (error "BEGIN should be a number."))
  (when (and (not (null end)) (not (numberp end))) (error "END should be a number."))
  (if (null end)
    (loop for number to begin collect number)
    (loop for number from begin to end collect number)))

(apply '++ (range 1 10))

(fmakunbound '++)
