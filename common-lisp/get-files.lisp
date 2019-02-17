(defvar *max-indent-width* 4)
(defvar *file-level* 0)
(defvar *ignored-paths* '("." ".." ".git" "node_modules"))

(defun list-files (&optional (directory-path "./"))
  "This will list files recursively, starting at the current directory."
  (let ((files (uiop:directory-files directory-path))
        (*file-level* (1+ *file-level*)))
    (loop :for file :in files
          :do (cond ((not (uiop:directory-pathname-p file))
                     (format t "~A~:[~;.~A~]~%" (pathname-name file) (pathname-type file) (pathname-type file)))
                    ((uiop:directory-pathname-p file)
                     (format t "~A~%" (pathname-name file)))))))
