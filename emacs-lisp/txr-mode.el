(require 'rx)
(require 'auto-complete)

(defalias 'ap 'apply-partially)

(defun ac-source-txr-candidates ()
  txr-mode-keywords)

(defun txr-document-symbol (symbol)
  (let ((x (assoc (or (and (stringp symbol) symbol)
                      (symbol-name symbol))
                  txr-docs)))
    (when x
      (concat "    " (nth 2 x) "\n\n" (nth 3 x)))))

(defconst ac-source-txr
  `((candidates . ac-source-txr-candidates)
    (document . txr-document-symbol)))


(defconst txr-mode-quoted-string-re
  (rx
   (group
    (or  (char ?\")
         (char ?`))
    (minimal-match
     (zero-or-more
      (or (seq ?\\ ?\\)
          (seq ?\\ ?\")
          (seq ?\\ (not (any ?\" ?\\)))
          (not (any ?\" ?\\)))))
    (or (char ?\")
        (char ?`)))))


(defconst txr-mode-regexp-re
  (rx
   (group
    "/"
    (minimal-match (zero-or-more
                    (not (any "/"))))
    "/")))


(defconst get-symbols-txr
  '(prinl
    (flatten
     (mapcar [chain cdr package-symbols]
             (package-alist)))))

(defconst get-symbols-command
  (concat "txr -e " (format "'%s'" get-symbols-txr)))

(defun txr-sort-keywords (keywords)
  (sort keywords
        (lambda (a b)
          (> (length a) (length b)))))

(defconst txr-mode-keywords
  (let
      ((txr-symbols (shell-command-to-string get-symbols-command))
       (extra-keywords '(end collect col rep repeat)))
    (->> (read txr-symbols)
      (append extra-keywords)
      (mapcar (ap 'format "%s"))
      txr-sort-keywords)))

(defconst txr-mode-builtins-re
  (let
      ((keyword-regexps (--map (concat "(\\<" it "\\>") txr-mode-keywords)))
    (concat "\\(" (s-join "\\|" keyword-regexps) "\\)")))


(defconst txr-mode-comment-re
  (rx
   (group
    (seq (or "@;" ";;")
         (minimal-match
          (one-or-more any))
         line-end))))


(defconst txr-mode-function-re
  (rx
   (seq
    (or "\(" )
    (group
     (minimal-match
      (one-or-more (not whitespace))))
    (or whitespace ")"))))


(defconst txr-mode-var-re
  (rx
   (seq "@" (optional "{")
        (group
         (one-or-more (any alnum "_")))
        (or "}" eow))))


(defconst txr-mode-kwargs-re
  (rx (group
       ":"(one-or-more alphanumeric))))


(defconst txr-font-lock-keywords
  (list
   (list txr-mode-quoted-string-re   1 font-lock-string-face)
   (list txr-mode-regexp-re          1 font-lock-string-face)
   (list txr-mode-var-re             1 font-lock-constant-face)
   (list txr-mode-comment-re         1 font-lock-comment-face)
   (list txr-mode-function-re        1 font-lock-keyword-face)
   (list txr-mode-builtins-re        1 font-lock-builtin-face)
   (list txr-mode-kwargs-re          1 font-lock-constant-face)))


(defun mode-setup ()
  (set (make-local-variable 'font-lock-defaults)
    '(txr-font-lock-keywords t))
  (add-to-list 'ac-sources 'ac-source-txr))

(defun turn-off-sly ()
  (when (boundp 'sly-mode) (sly-mode 0)))

(define-derived-mode txr-mode lisp-mode "TXR"
  "Major mode for editing TXR scripts"
  (mode-setup))

(define-derived-mode txr-lisp-mode lisp-mode "TXR Lisp"
  "Major mode for editing TXR scripts"
  (mode-setup))

(add-hook 'txr-mode-hook 'turn-off-sly)
(add-hook 'txr-lisp-mode-hook 'turn-off-sly)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.txr$" . txr-mode))
(add-to-list 'auto-mode-alist '("\\.tl$" . txr-lisp-mode))

(provide 'txr-mode)
(provide 'txr-lisp-mode)
;;; txr-mode.el ends here
