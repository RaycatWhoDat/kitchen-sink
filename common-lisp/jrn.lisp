(format t "What would you like to say?~%")

(let ((entry-text (read-line)))
  (with-open-file (journal-stream (merge-pathnames "journal.org" *default-pathname-defaults*)
                                  :direction :output
                                  :if-exists :append
                                  :if-does-not-exist :create)
    (multiple-value-bind (second minute hour date month year) (get-decoded-time)
      (format journal-stream "* [~d/~2,'0d/~d ~2,'0d:~2,'0d:~2,'0d]~% ~A~%~%"
              month
              date
              year
              hour
              minute
              second
              entry-text))))

