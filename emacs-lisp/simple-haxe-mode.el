;; Name: simple-haxe-mode
;; Author: Ray Perry
;; Date: 11/1/19
;; Version: 26.1

(defvar simple-haxe-mode-map nil
  "Keymap for `simple-haxe-mode'.")

(defvar simple-haxe-indent-offset tab-width
  "Indentation offset for `simple-haxe-mode'.")

(setq haxe-keywords
  '("break" "case" "cast" "catch" "continue" "default" "do" "dynamic" "else" "extern" "false" "final" "for" "if" "in" "inline" "macro" "new" "null" "return" "switch" "this" "throw" "true" "try" "var" "while" "abstract" "class" "enum" "extends" "function" "implements" "import" "interface" "operator" "overload" "override" "package" "private" "public" "static" "typedef" "untyped" "using"))

(setq simple-haxe-highlights
  `((,(regexp-opt haxe-keywords 'words) . font-lock-keyword-face)))

(defun shm/indent ()
  "Indent current line for `simple-haxe-mode'."
  (interactive)
  (let ((indent-col 0))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list 1)
            (when (looking-at "[([{]")
              (setq indent-col (+ indent-col simple-haxe-indent-offset))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at "[]})]") (>= indent-col simple-haxe-indent-offset))
        (setq indent-col (- indent-col simple-haxe-indent-offset))))

    ;; Indenting current line and putting point where it should be
  (let* ((parse-status
          (save-excursion (syntax-ppss (point-at-bol))))
         (offset (- (point) (save-excursion (back-to-indentation) (point)))))
    (indent-line-to indent-col)
    (when (> offset 0) (forward-char offset)))))

(setq simple-haxe-mode-map (make-sparse-keymap))
(setq electric-indent-chars (append "[]{}():;," electric-indent-chars))
(setq electric-layout-rules '((?\; . after) (?\{ . after) (?\} . before)))

(define-derived-mode simple-haxe-mode fundamental-mode "simple-haxe"
  "Major mode for editing Haxe source code with colors.

\\{simple-haxe-mode-map}"
  (kill-all-local-variables)
  (setq font-lock-defaults '(simple-haxe-highlights))
  ;; (set (make-local-variable 'indent-line-function) 'shm/indent)
  (set (make-local-variable 'indent-line-function) #'indent-relative))
