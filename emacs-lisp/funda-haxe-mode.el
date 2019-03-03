;; Funda HaXe Mode
;; Version: 0.1.2
;; Author: Pierre Arlaud
;; URL: https://github.com/pierre-arlaud/funda-haxe-mode

;; ------------------------------------------------------------------------
;; Copyright (C) 2015 Pierre Arlaud

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope htat it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; ------------------------------------------------------------------------

;; Supports Syntax highlighting and indenting
;; Based on fundamental mode to avoid future breaks
;;
;; Syntax highlighting inspired by http://ergoemacs.org/emacs/elisp_syntax_coloring.html
;; Indenting by http://stackoverflow.com/questions/4158216/emacs-custom-indentation
;; Syntax table inspired by http://emacswiki.org/emacs/ModeTutorial
;;

;; Define regexps of the haxe grammar
(setq funda-haxe-namespace '("import" "package"))
(setq funda-haxe-class-def '("class" "interface" "enum" "typedef" "enum"))
(setq funda-haxe-scope-modifiers '("static" "public" "private" "override" "get" "set" "inline" "extern"))
(setq funda-haxe-accessors-scope '("get" "set" "default" "null" "never" "dynamic")) ;; `null` is redundant because it's already a constant
(setq funda-haxe-keywords '("for" "if" "switch" "while" "try" "catch" "do" "else" "case" "default"))
(setq funda-haxe-sub-keywords '("break" "continue" "return" "new" "in" "extends" "implements" "var" "function"))
(setq funda-haxe-constant-expressions '("false" "true" "null"))
(setq funda-haxe-primary-expressions '("this" "super"))

;; Regular expressions based on lists
(setq funda-haxe-namespace-regexp (regexp-opt funda-haxe-namespace 'words))
(setq funda-haxe-class-def-regexp (regexp-opt funda-haxe-class-def 'words))
(setq funda-haxe-scope-modifiers-regexp (regexp-opt funda-haxe-scope-modifiers 'words))
(setq funda-haxe-accessors-scope-regexp (regexp-opt funda-haxe-accessors-scope 'words))
(setq funda-haxe-keywords-regexp (regexp-opt funda-haxe-keywords 'words))
(setq funda-haxe-sub-keywords-regexp (regexp-opt funda-haxe-sub-keywords 'words))
(setq funda-haxe-constant-expressions-regexp (regexp-opt funda-haxe-constant-expressions 'words))
(setq funda-haxe-primary-expressions-regexp (regexp-opt funda-haxe-primary-expressions 'words))

;; Regular expressions a little more complicated

(setq funda-haxe-identifier-regexp "\\<\\([a-z][A-Za-z0-9_]*\\)\\>")
(setq funda-haxe-variable-regexp "\\<\\([A-Z_]*\\|[a-z][A-Za-z0-9_]*\\)\\>") ; constants support
(setq funda-haxe-classname-regexp "\\<\\([A-Z][A-Za-z0-9_]*\\)\\>")
(setq funda-haxe-function-def-param-regexp (concat funda-haxe-identifier-regexp "[ \t]*:"))

(setq funda-haxe-namespace-package-regexp (concat "import " funda-haxe-identifier-regexp))
(setq funda-haxe-var-def-regexp (concat "\\(var\\)[ \t]*" funda-haxe-variable-regexp))

(setq funda-haxe-function-def-regexp (concat "\\(function\\)[ \t]*" funda-haxe-identifier-regexp "?[ \t]*("))
(setq funda-haxe-anonymous-function-def-regexp "\\(function\\)[ \t]*(")


(defun funda-haxe-walk-argument-list ()
  "Walk into the arguments list as a pre-match form of a anchored font-lock"
  (save-excursion
    (goto-char (match-end 0))
    (backward-char)
    (ignore-errors
      (forward-sexp))
    (point))
 )

;; Syntax Highlighting
(setq funda-haxe-font-lock-keywords
      `(

        (,funda-haxe-namespace-regexp (0 font-lock-keyword-face)
                                (,funda-haxe-identifier-regexp nil nil (0 font-lock-constant-face)))

        (,funda-haxe-var-def-regexp (1 font-lock-keyword-face) (2 font-lock-variable-name-face)
                             ;; Highlight possible accessors for the variable
                             (,funda-haxe-accessors-scope-regexp nil nil (0 font-lock-constant-face)))

       
        (,funda-haxe-function-def-regexp (1 font-lock-keyword-face) (2 font-lock-function-name-face)
                                  ;; Highlight possible parameters as variable names
                                   (,funda-haxe-function-def-param-regexp
                                   ;; Pre-match form
                                   (funda-haxe-walk-argument-list)
                                   ;; Post-match form
                                   (goto-char (match-end 0))
                                   (1 font-lock-variable-name-face)))

        (,funda-haxe-anonymous-function-def-regexp (1 font-lock-keyword-face)
                                  ;; Highlight possible parameters as variable names
                                   (,funda-haxe-function-def-param-regexp
                                   ;; Pre-match form
                                   (funda-haxe-walk-argument-list)
                                   ;; Post-match form
                                   (goto-char (match-end 0))
                                   (1 font-lock-variable-name-face)))
        
        (,funda-haxe-classname-regexp . font-lock-type-face)
        (,funda-haxe-class-def-regexp . font-lock-keyword-face)
        (,funda-haxe-scope-modifiers-regexp . font-lock-keyword-face)
        (,funda-haxe-keywords-regexp . font-lock-keyword-face)
        (,funda-haxe-sub-keywords-regexp . font-lock-keyword-face)
        (,funda-haxe-primary-expressions-regexp . font-lock-keyword-face)
        (,funda-haxe-constant-expressions-regexp . font-lock-constant-face)
        ))


;; Syntax table
(defvar funda-haxe-mode-syntax-table
  (let ((funda-haxe-mode-syntax-table (make-syntax-table)))
    ;; Support C-style comments
    (modify-syntax-entry ?/ ". 124b" funda-haxe-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" funda-haxe-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" funda-haxe-mode-syntax-table)
    (modify-syntax-entry ?' "\"" funda-haxe-mode-syntax-table)
	funda-haxe-mode-syntax-table)
  "Syntax table for funda-haxe-mode")



;; Indenting
(defvar funda-haxe-indent-offset tab-width
  "Indentation offset for `funda-haxe-mode'.")
(defun funda-haxe-indent-line ()
  "Indent current line for `funda-haxe-mode'."
  (interactive)
  (let ((indent-col 0))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list 1)
            (when (looking-at "[([{]")
              (setq indent-col (+ indent-col funda-haxe-indent-offset))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at "[]})]") (>= indent-col funda-haxe-indent-offset))
        (setq indent-col (- indent-col funda-haxe-indent-offset))))

    ;; Indenting current line and putting point where it should be
  (let* ((parse-status
          (save-excursion (syntax-ppss (point-at-bol))))
         (offset (- (point) (save-excursion (back-to-indentation) (point)))))
    (indent-line-to indent-col)
    (when (> offset 0) (forward-char offset)))))

;; Electric mode
(setq electric-indent-chars
      (append "[]{}():;," electric-indent-chars))
(setq electric-layout-rules
      '((?\; . after) (?\{ . after) (?\} . before)))

;; Mode definition
(define-derived-mode funda-haxe-mode fundamental-mode
  "haxe mode"
  "Fundamental Major mode for Haxe"
  (kill-all-local-variables)
  (interactive)
  (setq font-lock-defaults '((funda-haxe-font-lock-keywords)))
  (set-syntax-table funda-haxe-mode-syntax-table)
  (set (make-local-variable 'indent-line-function) 'funda-haxe-indent-line)
  (set (make-local-variable 'comment-start) "//")
  (set (make-local-variable 'comment-end) "")
  (setq major-mode 'funda-haxe-mode
        mode-name "haXe"
        local-abbrev-table funda-haxe-mode-abbrev-table
        abbrev-mode t)
)

(add-to-list 'auto-mode-alist '("\\.hx\\'" . funda-haxe-mode))

(provide 'funda-haxe-mode)
