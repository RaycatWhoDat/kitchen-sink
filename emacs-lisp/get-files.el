(defun print-files-recursively (directory-path traversal-level)
  (let ((ignored-paths '("." ".." ".git" "love" "target" "node_modules" "dist" ".dub"))
         (indentation-width 2))
    (dolist (file (directory-files directory-path))
      (when (not (member file ignored-paths))
        (insert (concat (make-string (* indentation-width traversal-level) ?\s) file "\n"))
        (when (f-directory-p (concat directory-path "/" file))
          (print-files-recursively (concat directory-path "/" file) (1+ traversal-level)))))))

(progn
  (switch-to-buffer-other-window "*File Listing*")
  (erase-buffer)
  (print-files-recursively ".." 0)
  (special-mode))
