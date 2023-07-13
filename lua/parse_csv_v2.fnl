(var index 0)
(each [line (io.lines "../d/MOCK_DATA.csv")]
  (set index (+ index 1))
  (each [first_name last_name email dob (string.gmatch line "(.+),(.+),(.+),(.+)")]
    (when (not (= index 1))
      (print (string.format "%20s %20s %30s %10s" first_name last_name email dob)))))
