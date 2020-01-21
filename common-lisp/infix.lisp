(defpackage infix
  (:use :cl))
(in-package :infix)

(defun nfx (stream char)
  "Infix reader macro time."
  (declare (ignore char))
  (list (quote quote) (read stream t nil t)))

(set-macro-character #\? #'nfx)
