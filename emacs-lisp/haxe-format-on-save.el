;; haxe-format-on-save
;;
;; This is a simple hook to run formatter on the current file when
;; `haxe-mode' is active. It is meant to run on `after-save-hook'.

(defun haxe-mode-format-on-save ()
  "Attempts to run a formatter on the current Haxe source file."
  (shell-command-to-string (concat "haxelib run formatter -s " (buffer-file-name)))
  (revert-buffer t t))

(add-hook 
  'haxe-mode-hook 
  (lambda () (add-hook 'after-save-hook 'haxe-mode-format-on-save nil t)))
