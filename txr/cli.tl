(define-option-struct cli-args nil
  (h help :bool "Print this help message.")
  (f folder :str "The folder you wish to spin-off.")
  (b branch :str "The branch you wish to use.")
  (r repo :str "The repository you wish to use."))

(defvarl prog-name *load-path*)
(defvarl invalid-option nil)

(let ((options (new cli-args)))
  options.(getopts *args*)

  (set invalid-option
    [some (list options.folder options.branch options.repo) null])

  (when (or options.help invalid-option)
    (put-line "Usage:\n")
    (put-line `  @{prog-name} [options] arg*`)
    options.(opthelp)
    (exit 1))

  (put-line `Would you like to spin-off @{options.folder} at @{options.branch} into @{options.repo}?`))
