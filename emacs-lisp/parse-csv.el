(let ((entry-format "First Name: %s\nLast Name: %s\nEmail: %s\nDate of Birth: %s\n\n")
       (records
        (with-temp-buffer
          (insert-file-contents-literally "MOCK_DATA.csv")
          (mapcar
            (lambda (record) (split-string record "," t))
            (split-string (buffer-string) "\n" t)))))
  (switch-to-buffer-other-window "*CSV File*")
  (dolist (record records)
    (insert (apply 'format entry-format record))))
