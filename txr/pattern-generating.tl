;; Macro `piterate`

;; Syntax:

;; (piterate initval pattern genfun [predfun])

;; Implementation: 

(defmacro piterate (seed pattern nextval : pred)
  (with-gensyms (ctx nxv lc prd)
    ^(let ((,ctx ,seed))
       (revappend ,ctx
         (make-lazy-cons
           (lambda (,lc)
             (when-match ,pattern ,ctx
               (let ((,nxv ,nextval)
                      (,prd ,pred))
                 (push ,nxv ,ctx)
                 (rplaca ,lc ,nxv)
                 (if ,prd
                   (and [,prd ,nxv] (rplacd ,lc (make-lazy-cons (lcons-fun ,lc))))
                   (rplacd ,lc (make-lazy-cons (lcons-fun ,lc))))))))))))

;; Description:

;; The `piterate` macro takes three arguments: `initval`, `pattern`, `genfun`, and a fourth optional argument, `predfun`.

;; The `initval` argument can be any iterable. The `pattern` argument can be any pattern that follows the semantics of `when-match`. The pattern variables bound in `pattern` will be accessible in the declaration of `genfun`. Normally, `genfun` should be a function that use as many parameters as there are pattern variables in `pattern`. For example:

;; (piterate "abcde" `a@{middle}e` (identity foo)) ;; Unbound reference
;; (piterate "abcde" `a@{middle}e` (identity middle)) ;; OK - "bcd"

;; The optional `predfun` argument can be any function that takes exactly one argument, which is the result of `genfun`. If `predfun` is not defined or `predfun` is defined but never evaluates to `nil`, `piterate` will be an infinite lazy list. The following equivalence holds:

;; (take-while (op >= 21) (piterate '(1 1) (@x @y . @nil) (+ x y))) <--> (piterate '(1 1) (@x @y . @nil) (+ x y) (op > 21))

;; Examples:

;; (piterate '(1) (@num . @nil) (succ num)) <--> (range 1)

(pprinl (piterate '(1) (@num . @nil) (succ num) (op > 10))) ;; <--> (range 1 10)

(pprinl (piterate '(1 1) (@x @y . @nil) (+ x y) (op > 21))) ;; (1 1 2 3 5 8 13 21)





