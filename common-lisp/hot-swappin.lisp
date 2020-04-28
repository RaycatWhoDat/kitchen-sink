(require :swank)
(require :bordeaux-threads)

(defvar *counter* 0)

(defun add1 () (setf *counter* (1+ *counter*)))
(defun minus1 () (setf *counter* (1- *counter*)))
(defun print-stuff () (format t "Hot swapping again: ~A~%" (minus1)))

(defun main-loop ()
  (bt:make-thread (lambda () (swank:create-server :port 4006)))
  (loop while t do
    (sleep 1)
    (print-stuff)))



