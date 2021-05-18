(defvar *TWO-SPACES* 2)
(defvar *ignored-paths*
  '("." ".." ".git" ".dub" "node_modules" "build" "target" "zef"))

(defun create-directory-entry (entry indentation-level)
  (cat-str (append (repeat '(#\ ) (* *TWO-SPACES* indentation-level)) entry)))

(defun print-files (: (directory-path ".") (indentation-level 0))
  (let ((directory (open-directory directory-path)))
    (whilet ((entry (get-line directory)))
      (let ((full-path (path-cat directory-path entry)))
        (unless (member entry *ignored-paths*)
          (pprinl (create-directory-entry entry indentation-level))
          (when (path-dir-p full-path)
            (print-files full-path (+ indentation-level 1))))))))

(print-files "..")
