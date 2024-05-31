;;; red-mode.el --- Red editing mode -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Chris Lamberson

;; Author: Chris Lamberson <chris@lamberson.online>
;; Version: 0.2.0
;; Url: https://github.com/dutch/red-mode
;; Keywords: languages
;; Package-Requires: ((emacs "25.0"))

;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This file adds a major mode for the Red programming language.

;;; Code:

(defgroup red nil
  "Support for Red code."
  :link '(url-link "https://www.red-lang.org")
  :group 'languages)

(defcustom red-indent-offset 4
  "Number of spaces per indent level."
  :type 'integer
  :group 'red)

(defvar red-mode-syntax-table
  (let ((table (make-syntax-table)))
	(modify-syntax-entry ?! "w" table)
	(modify-syntax-entry ?? "w" table)
	(modify-syntax-entry ?~ "w" table)
	(modify-syntax-entry ?* "w" table)
	table)
  "Syntax table for Red major mode.")

(defvar red-mode-keywords
  '("a-an" "about" "absolute" "acos"
	"action!" "action?" "add" "alert"
	"all" "all-word!" "all-word?" "also"
	"alter" "and" "and~" "any"
	"any-block!" "any-block?" "any-function!" "any-function?"
	"any-list!" "any-list?" "any-object!" "any-object?"
	"any-path!" "any-path?" "any-string!" "any-string?"
	"any-type!" "any-word!" "any-word?" "append"
	"arccosine" "arcsine" "arctangent" "arctangent2"
	"as" "as-color" "as-ipv4" "as-pair"
	"as-rgba" "asin" "ask" "at"
	"atan" "atan2" "attempt" "average"
	"back" "binary!" "binary?" "bind"
	"bitset!" "bitset?" "block!" "block?"
	"body-of" "break" "browse" "call"
	"case" "catch" "cause-error" "cd"
	"change" "change-dir" "char!" "char?"
	"charset" "checksum" "clean-path" "clear"
	"clear-reactions" "collect" "comma" "comment"
	"complement" "complement?" "compose" "construct"
	"context" "context?" "continue" "copy"
	"cos" "cosine" "CR" "create-dir"
	"datatype!" "datatype?" "date!" "date?"
	"dbl-quote" "debase" "decompress" "default-input-completer"
	"dehex" "delete" "difference" "dir"
	"dir?" "dirize" "divide" "do"
	"do-safe" "do-thru" "does" "dot"
	"dump-reactions" "either" "ellipsize-at" "email!"
	"email?" "empty?" "enbase" "equal?"
	"error!" "error?" "escape" "eval-set-path"
	"even?" "event!" "event?" "exclude"
	"exists-thru?" "exists?" "exit" "exp"
	"expand" "expand-directives" "extend" "external!"
	"extract" "extract-boot-args" "face?" "false"
	"fetch-help" "fifth" "file!" "file?"
	"find" "find-flag?" "first" "flip-exe-flag"
	"float!" "float?" "forall" "foreach"
	"forever" "form" "fourth" "func"
	"function" "function!" "function?" "get"
	"get-current-dir" "get-env" "get-path!" "get-path?"
	"get-word!" "get-word?" "greater-or-equal?" "greater?"
	"halt" "has" "hash!" "hash?"
	"head" "head?" "help" "help-string"
	"hex-to-rgb" "if" "immediate!" "immediate?"
	"in" "index?" "input" "insert"
	"integer!" "integer?" "internal!" "intersect"
	"issue!" "issue?" "keys-of" "last"
	"last-lf?" "length?" "lesser-or-equal?" "lesser?"
	"lf" "list-dir" "list-env" "lit-path!"
	"lit-path?" "lit-word!" "lit-word?" "ll"
	"load" "load-thru" "log-10" "log-2"
	"log-e" "logic!" "logic?" "loop"
	"lowercase" "ls" "make" "make-dir"
	"map!" "map?" "math" "max"
	"min" "mod" "modify" "modulo"
	"mold" "move" "multiply" "NaN?"
	"native!" "native?" "needs" "negate"
	"negative?" "new-line" "new-line?" "next"
	"no" "none" "none!" "none?"
	"normalize-dir" "not" "not-equal?" "now"
	"null" "number!" "number?" "object"
	"object!" "object?" "odd?" "off"
	"offset?" "on" "on-face-deep-change*" "on-parse-event"
	"op!" "op?" "or" "or~"
	"os-info" "overlap?" "pad" "pair!"
	"pair?" "paren!" "paren?" "parse"
	"parse-trace" "path!" "path-thru" "path?"
	"percent!" "percent?" "pi" "pick"
	"poke" "positive?" "power" "prin"
	"print" "probe" "put" "pwd"
	"q" "query" "quit" "quit-return"
	"quote" "random" "react" "react?"
	"read" "read-clipboard" "read-thru" "rebol"
	"recycle" "red-complete-input" "reduce" "refinement!"
	"refinement?" "reflect" "rejoin" "remainder"
	"remove" "remove-each" "repeat" "repend"
	"replace" "return" "reverse" "round"
	"routine" "routine!" "routine?" "same?"
	"save" "scalar!" "scalar?" "second"
	"select" "series!" "series?" "set"
	"set-current-dir" "set-env" "set-path!" "set-path?"
	"set-quiet" "set-word!" "set-word?" "shift"
	"shift-left" "shift-logical" "shift-right" "sign?"
	"sin" "sine" "size?" "skip"
	"slash" "sort" "source" "sp"
	"space" "spec-of" "split" "split-path"
	"sqrt" "square-root" "stats" "stop-reactor"
	"strict-equal?" "string!" "string?" "subtract"
	"suffix?" "sum" "swap" "switch"
	"tab" "tag!" "tag?" "tail"
	"tail?" "take" "tan" "tangent"
	"third" "throw" "time!" "time?"
	"to" "to-binary" "to-bitset" "to-block"
	"to-char" "to-date" "to-email" "to-file"
	"to-float" "to-get-path" "to-get-word" "to-hash"
	"to-hex" "to-image" "to-integer" "to-issue"
	"to-lit-path" "to-lit-word" "to-local-date" "to-local-file"
	"to-logic" "to-map" "to-none" "to-pair"
	"to-paren" "to-path" "to-percent" "to-red-file"
	"to-refinement" "to-set-path" "to-set-word" "to-string"
	"to-tag" "to-time" "to-tuple" "to-typeset"
	"to-unset" "to-url" "to-UTC-date" "to-word"
	"trim" "true" "try" "tuple!"
	"tuple?" "type?" "typeset!" "typeset?"
	"union" "unique" "unless" "unset"
	"unset!" "unset?" "until" "uppercase"
	"url!" "url?" "value?" "values-of"
	"vector!" "vector?" "wait" "what"
	"what-dir" "while" "within?" "word!"
	"word?" "words-of" "write" "write-clipboard"
	"write-stdout" "xor" "xor~" "yes"))

(defvar red-mode-constants
  '("Red"))

(defvar red-mode-font-lock-defaults
  `((("[\\|]" . font-lock-keyword-face)
	 (,(regexp-opt red-mode-keywords 'words) . font-lock-builtin-face)
	 (,(regexp-opt red-mode-constants 'words) . font-lock-constant-face))))

(defun red-indent-line ()
  "Indent current line as Red code."
  (interactive)
  (let* ((indent-level
		  (save-excursion
			(beginning-of-line)
			(cond ((not (re-search-backward "[]()[{}]" nil 'move))
				   0)
				  ((member (aref (match-string 0) 0) (string-to-list "[{("))
				   (let ((m (match-string 0)))
					 (+ (current-indentation) red-indent-offset)))
				  (t
				   (current-indentation))))))
	(if (save-excursion (beginning-of-line) (looking-at "[ \t]*[]})]"))
		(indent-line-to (- indent-level red-indent-offset))
	  (indent-line-to (max indent-level 0)))))

;;;###autoload
(define-derived-mode red-mode prog-mode "Red"
  "Major mode for Red code."
  :group 'red-mode
  :syntax-table red-mode-syntax-table
  (setq-local font-lock-defaults red-mode-font-lock-defaults)
  (setq-local indent-line-function 'red-indent-line))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.reds?\\'" . red-mode))

(provide 'red-mode)
;;; red-mode.el ends here
