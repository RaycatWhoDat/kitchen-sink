(defmacro --> (value . pipe) ^[(opip ,*pipe) ,value])

(defmacro lazy-iter (starting-value generator ending-value)
  (format t "~s\n" (apply '+ (list 1 2))))

(defun fib-generator (prev next)
  (lcons prev (fib-generator next (+ prev next))))

(defmacro piterate (seed pattern nextval)
  (with-gensyms (ctx nxv lc)
    ^(let ((,ctx ,seed))
       (revappend ,ctx
                  (make-lazy-cons
                    (lambda (,lc)
                      (when-match ,pattern ,ctx
                        (let ((,nxv ,nextval))
                          (push ,nxv ,ctx)
                          (rplaca ,lc ,nxv)
                          (rplacd ,lc
                                  (make-lazy-cons
                                    (lcons-fun ,lc)))))))))))
 
(each ((item (take 10 (piterate '(1 1) (@prev @next . @nil) (+ prev next)))))
  (format t "~s\n" item))



