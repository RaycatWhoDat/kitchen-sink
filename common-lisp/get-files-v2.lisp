(defun print-files (&optional (current-directory "..") (traversal-level 0))
  "Prints all the files recursively, starting at CURRENT-DIRECTORY."
  (declare (optimize (speed 0) (space 0) (debug 3)))
  (let ((ignored-paths '(".git" "love" "target" "dist" ".dub" "node_modules")))
    (dolist (file-entry (uiop:directory-files current-directory))
      (format t "~A~A~%"
        (make-sequence 'string (* 2 traversal-level) :initial-element #\ )
        (file-namestring file-entry)))
    
    (dolist (directory-entry (uiop:subdirectories current-directory))
      (let ((subdirectory-name (car (last (pathname-directory directory-entry)))))
        (unless (member subdirectory-name ignored-paths)
          (print-files
            (namestring
              (make-pathname
                :directory (pathname-directory (truename current-directory))
                :name subdirectory-name))
            (1+ traversal-level)))))))
