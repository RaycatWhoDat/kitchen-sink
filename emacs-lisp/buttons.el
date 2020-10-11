(require 'widget)

(eval-when-compile
  (require 'wid-edit))

(progn
  (interactive)
  (switch-to-buffer "*Widget Example*")
  (kill-all-local-variables)
  (let ((inhibit-read-only t))
    (erase-buffer))
  (remove-overlays)
  (widget-create
    'push-button
    :notify (lambda (&rest ignore) (message "Congratulations!"))
    "Click me!")
  (use-local-map widget-keymap)
  (widget-setup))
