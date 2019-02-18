(defvar *ignored-paths* '("./" "../" ".git/" "node_modules/"))

(labels ((print-file (directory-pathname)
           (unless (some (lambda (ignored-path)
                           ;; (print ignored-path)
                           ;; (print (car (last (pathname-directory directory-pathname))))
                           (unless (eq (car (last (pathname-directory directory-pathname))) :UP)
                             (or (search ignored-path (car (last (pathname-directory directory-pathname))))
                                 (eql ignored-path (car (last (pathname-directory directory-pathname))))))) *ignored-paths*)
             (format t "~A~%" directory-pathname)
             (let ((files (uiop:directory-files directory-pathname)))
               (loop :for file :in files
                     :do (format t "~A~A~:[~;.~A~]~%"
                                 directory-pathname
                                 (pathname-name file)
                                 (pathname-type file)
                                 (pathname-type file)))))))
  (uiop:collect-sub*directories "../" t t #'print-file))
