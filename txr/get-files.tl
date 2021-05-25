(defvar *TWO-SPACES* 2)
(defvar *ignored-paths*
  '("." ".." ".git" ".gitattributes" ".gitignore" ".dub" "node_modules" "build" "target" "zef"))

(defun print-listing (entry indentation-level)
  (pprinl (cat-str (append (repeat '(#\ ) (* *TWO-SPACES* indentation-level)) entry))))

(defun do-files (callback : (directory-path ".") (indentation-level 0))
  (each ((entry (sort (get-lines (open-directory directory-path)))))
    (let ((full-path (path-cat directory-path entry)))
      (unless (member entry *ignored-paths*)
        (eval ^(,callback ,entry ,indentation-level))
        (when (path-dir-p full-path)
          (do-files callback full-path (+ indentation-level 1)))))))

(do-files 'print-listing (or (car *args*) ".."))
