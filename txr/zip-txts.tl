(each ((number (file-get-lines "formatted_numbers.txt"))
        (text (file-get-lines "formatted_text.txt"))
        (type (file-get-lines "formatted_types.txt")))
  (file-append-string "final_conversion.csv" `@number|@text|@type\n`))
