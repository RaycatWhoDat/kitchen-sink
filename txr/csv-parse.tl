(each ((line (cdr (file-get-lines "MOCK_DATA.csv"))))
  (put-line line))
