(each ((first-name (file-get-lines "first_names.txt"))
        (last-name (file-get-lines "last_names.txt"))
        (email (file-get-lines "emails.txt"))
        (dob (file-get-lines "dobs.txt")))
  (file-append-string
    "final_conversion.csv"
    `@{first-name}|@{last-name}|@email|@dob\n`))
