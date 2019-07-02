#!/usr/bin/env sbcl --script

(defun print-files (&optional (current-directory ".."))
  "Prints all the files recursively, starting at CURRENT-DIRECTORY."
  (let ((ignored-paths '(".git" "love" "target" "dist" ".dub" "node_modules")))
    (dolist (entry (directory (concatenate 'string current-directory "/**/*.*")))
      (unless (intersection (pathname-directory entry) ignored-paths :test #'string=)
        (format t "~A~%" entry)))))

(print-files)
