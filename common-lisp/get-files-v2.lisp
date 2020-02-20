(defun print-files (&optional (relative-directory "..") (traversal-level 0))
  "Prints all the files recursively, starting at RELATIVE-DIRECTORY."
  (declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
  (let ((ignored-paths '(".git" "love" "target" "dist" ".dub" "node_modules"))
         (current-location (uiop:resolve-location (truename relative-directory))))
    (loop for listing in (append (uiop:directory-files current-location) (uiop:subdirectories current-location))
      do (format t "~A~A~%"
           (make-sequence 'string (* 2 traversal-level) :initial-element #\ )
           (if (string= (file-namestring listing) "")
             (car (last (pathname-directory listing)))
             (file-namestring listing)))
      when (uiop:directory-exists-p listing)
      unless (member (car (last (pathname-directory listing))) ignored-paths :test 'string=)
      do (print-files listing (1+ traversal-level)))))
