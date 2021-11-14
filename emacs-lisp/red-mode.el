;;; red-mode.el --- EMACS RED Editing Mode

;;-- History -------------------------------------------------------------
;;
;;   Original: jrm <bitdiddle@hotmail.com> 1998 from Scheme mode.
;;   Adapted-by: Marcus Petersson <d4marcus@dtek.chalmers.se>
;;   Modified-by: Jeff Kreis <jeff@rebol.com> 1999
;;   Updated-by: Sterling Newton <sterling@rebol.com> 2001
;;   Updated-by: Unchartedworks 2017
;;   Updated-by: Ray Perry <rmperry09@gmail.com> 2021
;;   Keywords: languages, REBOL, Red, lisp
;;
;;-------------------------------------------------------------------------

;;; Code:

(defvar red nil
  "Support for the RED programming language, <http://www.red-lang.org/>")
;  :group 'languages)

(defvar red-red-command "red"
  "*Shell command used to start RED interpreter.")
;  :type 'string
;  :group 'red)

(defvar red-indent-offset 4
  "*Amount of offset per level of indentation.")
;  :type 'integer
;  :group 'red)

(defvar red-backspace-function 'backward-delete-char-untabify
  "*Function called by `red-electric-backspace' when deleting backwards.")
;  :type 'function
;  :group 'red)

(defvar red-delete-function 'delete-char
  "*Function called by `red-electric-delete' when deleting forwards.")
;  :type 'function
;  :group 'red)

;;;###autoload
(defun red-mode ()
  "Major mode for editing RED code.

Commands:
Delete converts tabs to spaces as it moves back.
Blank lines separate paragraphs.  Semicolons start comments.
\\{red-mode-map}
Entry to this mode calls the value of red-mode-hook
if that value is non-nil."
  (interactive)
  (column-number-mode t)
  (kill-all-local-variables)
  (red-mode-initialize)
  (red-mode-variables)
  (run-hooks 'red-mode-hook))

(defun red-mode-initialize ()
  (use-local-map red-mode-map)
  (setq mode-name "RED" major-mode 'red-mode)
  (setq tab-width 4) ; Added these two. -jeff
  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))

(defun beginning-of-red-definition ()
  "Moves point to the beginning of the current RED definition"
  (interactive)
  (re-search-backward "^[a-zA-Z][a-zA-Z0-9---_]*:" nil 'move)
  )

(defun red-comment-indent (&optional pos)
  (save-excursion
    (if pos (goto-char pos))
    (cond ((looking-at ";;;") (current-column))
          ((looking-at ";;")
           (let ((tem (guess-red-indent)))
             (if (listp tem) (car tem) tem)))
          (t
           (skip-chars-backward " \t")
           (max (if (bolp) 0 (1+ (current-column)))
                comment-column)))))

(defvar red-indent-function 'red-indent-function "")

(defun red-indent-line (&optional whole-exp)
  "Indent current line as RED code.
With argument, indent any additional lines of the same expression
rigidly along with this one."
  (interactive "P")
  (let ((indent (guess-red-indent)) shift-amt beg end
	(pos (- (point-max) (point))))
    (beginning-of-line)
    (setq beg (point))
    (skip-chars-forward " \t")
    (if (looking-at "[ \t]*;;;")
	;; Don't alter indentation of a ;;; comment line.
	nil
      (if (listp indent) (setq indent (car indent)))
	  (if (looking-at "[ \t]*[])]") (setq indent (- indent 4)))
      (setq shift-amt (- indent (current-column)))
      (if (zerop shift-amt)
	  nil
	(delete-region beg (point))
	(indent-to indent))
      ;; If initial point was within line's indentation,
      ;; position after the indentation.  Else stay at same point in text.
      (if (> (- (point-max) pos) (point))
	  (goto-char (- (point-max) pos)))
      ;; If desired, shift remaining lines of expression the same amount.
      (and whole-exp (not (zerop shift-amt))
	   (save-excursion
	     (goto-char beg)
	     (forward-sexp 1)
	     (setq end (point))
	     (goto-char beg)
	     (forward-line 1)
	     (setq beg (point))
	     (> end beg))
	   (indent-code-rigidly beg end shift-amt)))))


(defun guess-red-indent (&optional parse-start)
  "Return appropriate indentation for current line as red code.
In usual case returns an integer: the column to indent to.
Can instead return a list, whose car is the column to indent to.
This means that following lines at the same level of indentation
should not necessarily be indented the same way.
The second element of the list is the buffer position
of the start of the containing expression."
  (save-excursion
    (beginning-of-line)
    (let ((indent-point (point)) 
          indenting-block-p
          state
          block-depth
          desired-indent
          (retry t)
	  last-expr
          containing-expr
          first-expr-list-p)
      (setq indenting-block-p (looking-at "^[ \t]*\\s("))
      (if parse-start
	  (goto-char parse-start)
	(beginning-of-red-definition))
      ;; Find outermost containing expr
      (while (< (point) indent-point)
	(setq state (parse-partial-sexp (point) indent-point 0)))
      ;; Find innermost containing sexp
      (while (and retry (setq block-depth (car state)) (> block-depth 0))
	(setq retry nil)
	(setq last-expr (nth 2 state))
	(setq containing-expr (car (cdr state)))
	;; Position following last unclosed open.
	(goto-char (1+ containing-expr))
	;; Is there a complete sexp since then?
	(if (and last-expr (> last-expr (point)))
	    ;; Yes, but is there a containing expr after that?
	    (let ((peek (parse-partial-sexp last-expr indent-point 0)))
	      (if (setq retry (car (cdr peek))) (setq state peek))))
	(if (not retry)
	    ;; Innermost containing sexp found
	    (progn
	      (goto-char (1+ containing-expr))
	      (if (not last-expr)
		  (setq desired-indent (* block-depth red-indent-offset))
		(setq desired-indent (* block-depth red-indent-offset))
;;;-----------------------------------------------------------------------------
;;; Seems to work the same with or without the commented-out lines below -Marcus
;;;
; 		;; Move to first expr after containing open paren
; 		(parse-partial-sexp (point) last-expr 0 t)
; 		(setq first-expr-list-p (looking-at "\\s("))
; 		(cond
; 		 ((> (save-excursion (forward-line 1) (point))
; 		     last-expr)
; 		  ;; Last expr is on same line as containing expr.
; 		  ;; It's almost certainly a function call.
; 		  (parse-partial-sexp (point) last-expr 0 t)
; 		  (if (/= (point) last-expr)
; 		      ;; Indent beneath first argument or, if only one expr
; 		      ;; on line, indent beneath that.
; 		      (progn (if indenting-block-p (forward-sexp 1))
; 			     (parse-partial-sexp (point) last-expr 0 t)))
; 		  (backward-prefix-chars))
; 		 (t
; 		  ;; Indent beneath first expr on same line as last-expr.
; 		  ;; Again, it's almost certainly a function call.
; 		  (goto-char last-expr)
; 		  (beginning-of-line)
; 		  (parse-partial-sexp (point) last-expr 0 t)
; 		  (backward-prefix-chars)))
;;;------------------------------------------------------------------------------
                ))))
      (cond ((car (nthcdr 3 state))
	     ;; Inside a string, don't change indentation.
	     (goto-char indent-point)
	     (skip-chars-forward " \t")
	     (setq desired-indent (current-column)))
	    ((not (or desired-indent
		      (and (boundp 'red-indent-function)
			   red-indent-function
			   (not retry)
			   (setq desired-indent
				 (funcall red-indent-function
					  indent-point state)))))
	     ;; Use default indentation if not computed yet
	     (setq desired-indent (current-column))))
      desired-indent
      )))

(defun red-indent-function (indent-point state)
  (let ((normal-indent (current-column)))
    (save-excursion
      (goto-char (1+ (car (cdr state))))
      (re-search-forward "\\sw\\|\\s_")
      (if (/= (point) (car (cdr state)))
	  (let ((function (buffer-substring (progn (forward-char -1) (point))
					    (progn (forward-sexp 1) (point))))
		method)
	    (setq function (downcase function))
	    (setq method (get (intern-soft function) 'red-indent-function))
	    (cond ((integerp method)
		   (red-indent-specform method state indent-point))
		  (method
		   (funcall method state indent-point))
                  ))))))

(defvar red-body-indent 2 "")

(defun red-indent-specform (count state indent-point)
  (let ((containing-form-start (car (cdr state))) (i count)
	body-indent containing-form-column)
    ;; Move to the start of containing form, calculate indentation
    ;; to use for non-distinguished forms (> count), and move past the
    ;; function symbol.  red-indent-function guarantees that there is at
    ;; least one word or symbol character following open paren of containing
    ;; form.
    (goto-char containing-form-start)
    (setq containing-form-column (current-column))
    (setq body-indent (+ red-body-indent containing-form-column))
    (forward-char 1)
    (forward-sexp 1)
    ;; Now find the start of the last form.
    (parse-partial-sexp (point) indent-point 1 t)
    (while (and (< (point) indent-point)
		(condition-case nil
		    (progn
		      (setq count (1- count))
		      (forward-sexp 1)
		      (parse-partial-sexp (point) indent-point 1 t))
		  (error nil))))
    ;; Point is sitting on first character of last (or count) sexp.
    (cond ((> count 0)
	   ;; A distinguished form.  Use double red-body-indent.
	   (list (+ containing-form-column (* 2 red-body-indent))
		 containing-form-start))
	  ;; A non-distinguished form. Use body-indent if there are no
	  ;; distinguished forms and this is the first undistinguished
	  ;; form, or if this is the first undistinguished form and
	  ;; the preceding distinguished form has indentation at least
	  ;; as great as body-indent.
	  ((and (= count 0)
		(or (= i 0)
		    (<= body-indent normal-indent)))
	   body-indent)
	  (t
	   normal-indent))))

(defun red-indent-defform (state indent-point)
  (goto-char (car (cdr state)))
  (forward-line 1)
  (if (> (point) (car (cdr (cdr state))))
      (progn
	(goto-char (car (cdr state)))
	(+ red-body-indent (current-column)))))

(defun would-be-symbol (string)
  (not (string-equal (substring string 0 1) "(")))

(defun next-sexp-as-string ()
  ;; Assumes that protected by a save-excursion
  (forward-sexp 1)
  (let ((the-end (point)))
    (backward-sexp 1)
    (buffer-substring (point) the-end)))

(defun red-let-indent (state indent-point)
  (skip-chars-forward " \t")
  (if (looking-at "[-a-zA-Z0-9+*/?!@$%^&_:~]")
      (red-indent-specform 2 state indent-point)
      (red-indent-specform 1 state indent-point)))

(defun red-indent-expr ()
  "Indent each line of the list starting just after point."
  (interactive)
  (let ((indent-stack (list nil)) (next-depth 0) bol
	outer-loop-done inner-loop-done state this-indent)
    (save-excursion (forward-sexp 1))
    (save-excursion
      (setq outer-loop-done nil)
      (while (not outer-loop-done)
	(setq last-depth next-depth
	      innerloop-done nil)
	(while (and (not innerloop-done)
		    (not (setq outer-loop-done (eobp))))
	  (setq state (parse-partial-sexp (point) (progn (end-of-line) (point))
					  nil nil state))
	  (setq next-depth (car state))
	  (if (car (nthcdr 4 state))
	      (progn (indent-for-comment)
		     (end-of-line)
		     (setcar (nthcdr 4 state) nil)))
	  (if (car (nthcdr 3 state))
	      (progn
		(forward-line 1)
		(setcar (nthcdr 5 state) nil))
	    (setq innerloop-done t)))
	(if (setq outer-loop-done (<= next-depth 0))
	    nil
	  (while (> last-depth next-depth)
	    (setq indent-stack (cdr indent-stack)
		  last-depth (1- last-depth)))
	  (while (< last-depth next-depth)
	    (setq indent-stack (cons nil indent-stack)
		  last-depth (1+ last-depth)))
	  (forward-line 1)
	  (setq bol (point))
	  (skip-chars-forward " \t")
	  (if (or (eobp) (looking-at "[;\n]"))
	      nil
	    (if (and (car indent-stack)
		     (>= (car indent-stack) 0))
		(setq this-indent (car indent-stack))
	      (let ((val (guess-red-indent
			  (if (car indent-stack) (- (car indent-stack))))))
		(if (integerp val)
		    (setcar indent-stack
			    (setq this-indent val))
		  (if (cdr val)
		      (setcar indent-stack (- (car (cdr val)))))
		  (setq this-indent (car val)))))
	    (if (/= (current-column) this-indent)
		(progn (delete-region bol (point))
		       (indent-to this-indent)))))))))

(provide 'red)


(defconst red-natives (regexp-opt '("all" "any" "arccosine" "arcsine" "arctangent" "arctangent2" "as" "as-pair" "bind" "break" "browse" "call" "case" "catch" "checksum" "complement?" "compose" "construct" "context?" "continue" "cosine" "debase" "dehex" "difference" "do" "does" "either" "enbase" "equal?" "exclude" "exit" "exp" "extend" "forall" "foreach" "forever" "func" "function" "get" "get-env" "greater-or-equal?" "greater?" "has" "if" "in" "intersect" "lesser-or-equal?" "lesser?" "list-env" "log-10" "log-2" "log-e" "loop" "lowercase" "max" "min" "NaN?" "negative?" "new-line" "new-line?" "not" "not-equal?" "now" "parse" "positive?" "prin" "print" "reduce" "remove-each" "repeat" "return" "same?" "set" "set-env" "shift" "sign?" "sine" "size?" "square-root" "stats" "strict-equal?" "switch" "tangent" "throw" "to-hex" "to-local-file" "try" "type?" "union" "unique" "unless" "unset" "until" "uppercase" "value?" "wait" "while" "zero?")))

(defconst red-functions (regexp-opt '("?" "??" "a-an" "about" "acos" "action?" "all-word?" "also" "alter" "any-block?" "any-function?" "any-list?" "any-object?" "any-path?" "any-string?" "any-word?" "asin" "ask" "atan" "atan2" "attempt" "binary?" "bitset?" "block?" "body-of" "cause-error" "cd" "center-face" "change-dir" "char?" "charset" "class-of" "clean-path" "clear-reactions" "collect" "comment" "common-substr" "context" "cos" "datatype?" "date?" "dir" "dir?" "dirize" "distance?" "do-actor" "do-events" "do-file" "do-safe" "do-thru" "draw" "dump-face" "dump-reactions" "ellipsize-at" "email?" "empty?" "error?" "eval-set-path" "exists-thru?" "expand" "expand-directives" "extract" "extract-boot-args" "face?" "fetch-help" "fifth" "file?" "filter" "first" "flip-exe-flag" "float?" "foldl" "foreach-face" "fourth" "function?" "get-path?" "get-scroller" "get-word?" "halt" "handle?" "hash?" "help" "help-string" "hex-to-rgb" "image?" "immediate?" "input" "insert-event-func" "integer?" "issue?" "keys-of" "last" "layout" "link-sub-to-parent" "link-tabs-to-parent" "list-dir" "lit-path?" "lit-word?" "ll" "load" "load-thru" "logic?" "ls" "make-dir" "map" "map*" "map2" "map?" "math" "metrics?" "mod" "modulo" "native?" "none?" "normalize-dir" "number?" "object" "object?" "offset?" "on-face-deep-change*" "on-parse-event" "op?" "overlap?" "pad" "pair?" "paren?" "parse-func-spec" "parse-trace" "path-thru" "path?" "percent?" "probe" "pwd" "q" "quit" "quote" "react" "react?" "read-thru" "red-complete-file" "red-complete-input" "red-complete-path" "refinement?" "rejoin" "remove-event-func" "repend" "replace" "request-dir" "request-file" "request-font" "routine" "routine?" "save" "scalar?" "second" "series?" "set-flag" "set-focus" "set-path?" "set-word?" "show" "sin" "size-text" "source" "spec-of" "split" "split-path" "sqrt" "string?" "suffix?" "tag?" "tan" "third" "time?" "to-binary" "to-bitset" "to-block" "to-char" "to-date" "to-email" "to-file" "to-float" "to-get-path" "to-get-word" "to-hash" "to-image" "to-integer" "to-issue" "to-lit-path" "to-lit-word" "to-logic" "to-map" "to-none" "to-pair" "to-paren" "to-path" "to-percent" "to-red-file" "to-refinement" "to-set-path" "to-set-word" "to-string" "to-tag" "to-time" "to-tuple" "to-typeset" "to-unset" "to-url" "to-word" "tuple?" "typeset?" "unset?" "unview" "update-font-faces" "url?" "values-of" "vector?" "View" "what" "what-dir" "within?" "word?" "words-of")))

(defconst red-ops (regexp-opt '("%" "*" "**" "+" "-" "/" "//" "<" "<<" "<=" "<>" "=" "==" "=?" ">" ">=" ">>" ">>>" "and" "is" "or" "xor")))

(defconst red-actions (regexp-opt '("absolute" "add" "and~" "append" "at" "back" "change" "clear" "complement" "copy" "delete" "divide" "even?" "find" "form" "head" "head?" "index?" "insert" "length?" "make" "modify" "mold" "move" "multiply" "negate" "next" "odd?" "or~" "pick" "poke" "power" "put" "random" "read" "reflect" "remainder" "remove" "reverse" "round" "select" "skip" "sort" "subtract" "swap" "tail" "tail?" "take" "to" "trim" "write" "xor~")))

(defconst red-types1 (regexp-opt '("binary" "bitset" "block" "char" "date" "decimal" "email" "event" "file" "get-word" "hash" "image" "integer" "issue" "list" "lit-path" "lit-word" "logic" "money" "none" "pair" "paren" "path" "refinement" "set-path" "set-word" "string" "tag" "time" "tuple" "url" "word")))

(defconst red-types2 (regexp-opt '("action" "any-block" "any-function" "any-string" "any-type" "any-word" "datatype" "error" "function" "library" "native" "number" "object" "op" "port" "routine" "series" "struct" "symbol" "unset")))

(defconst red-refinement-end "\\)\\(/[0-9a-zA-Z]+\\)*\\)[^-_/0-9a-zA-Z]")

(defvar red-font-lock-keywords
  (list
   (list (concat "[^-_/]\\<\\(\\(" red-natives red-refinement-end) '1 'font-lock-keyword-face) ; native
   (list (concat "[^-_/]\\<\\(\\(" red-functions red-refinement-end) '1 'font-lock-keyword-face) ; function
   (list (concat "[^-_/]\\<\\(\\(" red-ops red-refinement-end) '1 'font-lock-doc-string-face) ; op
   (list (concat "[^-_/]\\<\\(\\(" red-actions red-refinement-end) '1 'font-lock-type-face) ; action
   (list (concat "\\<\\(to-\\(" red-types1 "\\)\\)") '1 'font-lock-keyword-face) ; to-type
   (list (concat "\\(\\(" red-types1 "\\|" red-types2 "\\)\\(!\\|\\?\\)\\)") '1 'font-lock-type-face) ; type? or type! 
   '("\\([^][ \t\r\n{}()]+\\):"  1 font-lock-function-name-face) ; define variable
   '("\\([^][ \t\r\n{}()]+\\):[ ]*\\(does\\|func\\(tion\\)?\\)" (1 'underline prepend) (2 font-lock-keyword-face)) ; define function
   '("\\(:\\|'\\)\\([^][ \t\r\n{}()]+\\)"  2 font-lock-variable-name-face) ; value or quoted
   '("\\(:?[0-9---]+:[:.,0-9]+\\)" 1 font-lock-preprocessor-face t) ; time
   '("\\([0-9]+\\(-\\|/\\)[0-9a-zA-Z]+\\2[0-9]+\\)" 1 font-lock-preprocessor-face t) ; date
   '("\\($[0-9]+\\(\\.\\|,\\)[0-9][0-9]\\)" 1 font-lock-preprocessor-face t) ; money
   '("\\([0-9]+\\.[0-9]+\\.\\([0-9]+\\(\\.[0-9]+?\\)?\\)?\\)" 1 font-lock-preprocessor-face t) ; tuple
   '("\\([0-9a-z]+@\\([0-9a-z]+\\.\\)+[a-z]+\\)" 1 font-lock-preprocessor-face t) ; email
   '("\\(http\\|ftp\\|mailto\\|file\\):[^ \n\r]+" 1 font-lock-preprocessor-face t) ; URL
   '("\\(%[^ \n\r]+\\)" 1 font-lock-preprocessor-face) ; file name
   '("\\(#\\([0-9a-zA-Z]+\\-\\)*[0-9a-zA-Z]+\\)" 1 font-lock-preprocessor-face t) ; issue

   ;; comment out these two (long string, binary) if you think it runs too slow
   '("[^#]\\({[^{}]*}\\)" 1 font-lock-string-face t) ; long string
   '("\\(\\(2\\|64\\)?#{[0-9a-zA-Z]+}\\)" 1 font-lock-preprocessor-face t) ; binary
   )
  "Additional expressions to highlight in RED mode.")


(defvar red-mode-syntax-table nil 
  "Syntax table for RED buffers.")

(if (not red-mode-syntax-table)
    (let ((i 0))
      (setq red-mode-syntax-table (make-syntax-table))
      (set-syntax-table red-mode-syntax-table)

      ;; Default is `word' constituent.
      (while (< i 256)
        (modify-syntax-entry i "_   ")
        (setq i (1+ i)))

      ;; Digits are word components.
      (setq i ?0)
      (while (<= i ?9)
        (modify-syntax-entry i "w   ")
        (setq i (1+ i)))

      ;; As are upper and lower case.
      (setq i ?A)
      (while (<= i ?Z)
        (modify-syntax-entry i "w   ")
        (setq i (1+ i)))
      (setq i ?a)
      (while (<= i ?z)
        (modify-syntax-entry i "w   ")
        (setq i (1+ i)))

      ;; Whitespace
      (modify-syntax-entry ?\t "    ")
      (modify-syntax-entry ?\n ">   ")
      (modify-syntax-entry ?\f "    ")
      (modify-syntax-entry ?\r "    ")
      (modify-syntax-entry ?  "    ")

      ;; Delimiters
      (modify-syntax-entry ?\[ "(]  ")
      (modify-syntax-entry ?\] ")[  ")
      (modify-syntax-entry ?\( "()  ")
      (modify-syntax-entry ?\) ")(  ")

      ;; comments
      (modify-syntax-entry ?\; "<   ")
      (modify-syntax-entry ?\" "\"    ")
      (modify-syntax-entry ?{ "    ")
      (modify-syntax-entry ?} "    ")
      (modify-syntax-entry ?' "  p")
      (modify-syntax-entry ?` "  p")

      (modify-syntax-entry ?^ "\\   ")))

(defvar red-mode-abbrev-table nil 
  "*Abbrev table for red-mode buffers")

(define-abbrev-table 'red-mode-abbrev-table ())

(defun red-mode-variables ()
  (set-syntax-table red-mode-syntax-table)
  (setq local-abbrev-table red-mode-abbrev-table)

  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'red-indent-line)
  (make-local-variable 'parse-expr-ignore-comments)
  (setq parse-expr-ignore-comments t)
  (make-local-variable 'comment-start)
  (setq comment-start ";")
  (make-local-variable 'comment-start-skip)
  ;; Look within the line for a ; following an even number of backslashes
  ;; after either a non-backslash or the line beginning.
  (setq comment-start-skip "\\(\\(^\\|[^\\\\\n]\\)\\(\\\\\\\\\\)*\\);+[ \t]*")
  (make-local-variable 'comment-column)
  (setq comment-column 40)
  (make-local-variable 'comment-indent-function)
  (setq comment-indent-function 'red-comment-indent)
  (make-local-variable 'parse-expr-ignore-comments)
  (setq parse-expr-ignore-comments t)
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(red-font-lock-keywords nil nil))
  (make-local-variable 'mode-line-process)
  (setq mode-line-process '("" red-mode-line-process)))

(defvar red-mode-line-process "")

(defun red-mode-commands (map)
  (define-key map "\e\C-a" 'beginning-of-red-definition)
  (define-key map "\t" 'red-indent-line)
  (define-key map "\e\C-q" 'red-indent-expr))

(defvar red-mode-map nil)
(if (not red-mode-map)
    (progn
      (setq red-mode-map (make-sparse-keymap))
      (red-mode-commands red-mode-map)))

;;;###autoload
(add-to-list 'auto-mode-alist        '("\\.red\\'" . red-mode))
;;(add-to-list 'auto-mode-alist        '("\\.reds\\'" . red-mode))
