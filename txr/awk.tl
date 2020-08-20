(awk
  (:inputs "MOCK_DATA.csv")
  (:set fs ",")
  ((>= nr 2)
    (prn "First Name: " [f 0])
    (prn "Last Name: " [f 1])
    (prn "Email: " [f 2])
    (prn "Date of Birth: " [f 3] "\n")))
