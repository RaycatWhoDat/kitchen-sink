(define-option-struct cli-args nil
  (h help :bool "Print this help message.")
  (f folder :str "The folder you wish to spin-off.")
  (b branch :str "The branch you wish to use.")
  (r repo :str "The repository you wish to use."))

(defvarl prog-name *load-path*)
(defvarl invalid-option nil)

(let ((options (new cli-args)))
  ;; (qref options (getopts *args*))
  options.(getopts *args*)

  (set invalid-option
    (null (or options.folder options.branch options.repo)))

  (when (or options.help invalid-option)
    (put-line "Usage:\n")
    (put-line `  @{prog-name} [options] arg*`)
    ;; (qref options (opthelp))
    options.(opthelp)
    (exit 1)))
