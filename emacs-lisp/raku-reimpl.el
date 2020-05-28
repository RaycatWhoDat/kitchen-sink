(defun polymod (base &rest mods)
  "Given a BASE which is a number, return a list of places based
on MODS."
  (let ((mutable-base base))
    (loop
      for divisor in mods
      collect (mod mutable-base divisor) into results
      and do (setq mutable-base (/ mutable-base divisor))
      finally (return (nconc results (list mutable-base))))))

(ert-deftest polymod-tests ()
  "Tests the definition and usage of POLYMOD."
  (should (equal (polymod 12) '(12)))
  (should (equal (polymod 12 10) '(2 1)))
  (should (equal (polymod 123 10 10) '(3 2 1)))
  (should (equal (polymod 64921 10 10 10 10) '(1 2 9 4 6))))
