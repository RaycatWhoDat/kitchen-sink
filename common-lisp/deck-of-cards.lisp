(defun flatten (obj)
  (do* ((result (list obj))
        (node result))
       ((null node) (delete nil result))
    (cond ((consp (car node))
           (when (cdar node) (push (cdar node) (cdr node)))
           (setf (car node) (caar node)))
          (t (setf node (cdr node))))))

(defun range (max &key (min 0) (step 1))
  (loop for element from min to max by step collect element))

(defparameter all-values (flatten (loop repeat 4 collect `(A ,(range 10 :min 2) J Q K))))

(loop for index from 0
      for card in all-values
      collect (list card (nth (mod index 4) '(♥ ♦ ♠ ♣))))

