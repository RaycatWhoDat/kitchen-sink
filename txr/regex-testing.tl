(each ((line (file-get-lines "../d/MOCK_DATA.csv")))
  (match-case (tok-str line #/(".+"|[^,])+/)
    ((@first_name @last_name @email @dob)
      (pprinl (fmt "~20a ~20a ~30a ~15a" first_name last_name email dob)))))
