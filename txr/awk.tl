(awk
  (:inputs "MOCK_DATA.csv")
  (:set fs ",")
  (:let (entry-format "First Name: ~a\nLast Name: ~a\nEmail: ~a\nDate of Birth: ~a\n"))
  ((>= nr 2)
    (prn (format nil entry-format [f 0] [f 1] [f 2] [f 3]))))
