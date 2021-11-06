;; -*- coding: utf-8; lexical-binding: t; -*-

;;; red-mode.el - A major mode for writing Red scripts.

;; Author: Ray M. Perry (rmperry09@gmail.com)
;; Version: 0.0.1
;; Date: <2019-03-29 Fri>
;; Repository: TBD

;; Pre-Red header text
;; \\([\\0-\\377[:nonascii:][:ascii:]]*?\\)Red.*\\[\\|

(load-file "./red-keywords.el")

(setq red-font-lock-keywords
  (let* ((red-keywords-regexp (regexp-opt red-keywords 'words)))
    `(("\\(comment\\ {[\\0-\\377[:nonascii:][:ascii:]]*?\\)}\\|;.+" . font-lock-comment-face)
      (".+\:" . font-lock-variable-name-face)
      ("{\\([\\0-\\377[:nonascii:][:ascii:]]*?\\)}" . font-lock-string-face)
      ("[a-zA-Z\-]+\\?\\|[a-zA-Z\-]+\\!" . font-lock-constant-face)
      ("\\(.*\\(\\/.+\\)+\\)\\ " . font-lock-keyword-face)
      (,red-keywords-regexp . font-lock-keyword-face))))

(progn
  (setq red-mode-map (make-sparse-keymap))
  (define-key red-mode-map (kbd "TAB") 'tab-to-tab-stop))

(define-derived-mode red-mode fundamental-mode "Red"
  "Major mode for editing Red scripts.

\\{red-mode-map}"
  
  (setq font-lock-defaults '(red-font-lock-keywords))
  (setq-local comment-start "; ")
  (setq-local comment-end ""))

