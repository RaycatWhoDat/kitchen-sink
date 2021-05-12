(setq ldpl-mode-comments
  '("#"))

(setq ldpl-mode-section-function-keywords
  '("data"
     "procedure"
     "sub-procedure"
     "end sub-procedure"
     "sub"
     "end sub"
     "create statement"
     "executing"
     "parameters"))

(setq ldpl-mode-control-flow-keywords
  '("while"
     "repeat"
     "if"
     "else"
     "end"
     "for"
     "for each"
     "from"
     "to"
     "do"
     "then"
     "return"
     "break"
     "continue"))

(setq ldpl-mode-built-in-keywords
  '("call"
     "store"
     "display"
     "is"
     "in"
     "greater than"
     "less than"
     "not"
     "equal"
     "and"
     "or"
     "solve"
     "floor"
     "get random"
     "crlf"
     "push"
     "exit"
     "accept"
     "wait"
     "milliseconds"
     "local"))

(setq ldpl-mode-types-keywords
  '("number"
     "text"
     "list"
     "map"
     "vector"))

(setq ldpl-mode-lowercase-keywords
  (append
    ldpl-mode-section-function-keywords
    ldpl-mode-control-flow-keywords
    ldpl-mode-built-in-keywords
    ldpl-mode-types-keywords))

(setq ldpl-mode-uppercase-keywords
  (mapcar 'upcase ldpl-mode-keywords))

(setq ldpl-mode-keywords
  (append ldpl-mode-lowercase-keywords ldpl-mode-uppercase-keywords))

(setq ldpl-mode-file-extensions '("\\.ldpl$")))

(defun ldpl-mode-setup ()
  (setq-default indent-tabs-mode nil)
  (set (make-local-variable 'tab-stop-list) '(4 8)))

(define-generic-mode
  ldpl-mode
  ldpl-mode-comments
  ldpl-mode-keywords
  nil
  ldpl-mode-file-extensions
  (list 'ldpl-mode-setup)
  "Major mode for the LDPL Programming Language.")


  
  
  
