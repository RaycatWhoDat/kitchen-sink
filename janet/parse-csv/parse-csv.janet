(def csv-record
  '{
    :graph (* (+ :w :s (set "!@#$%^&*()./")))
    :main (some (* (<- (some :graph)) (? ",")))
   })

(defn read-lines [path] (string/split "\n" (slurp path)))

(loop [line :in (drop 1 (read-lines "./MOCK_DATA.csv"))]
  (def [first-name last-name email dob] (peg/match csv-record line))
  (print "First Name: " first-name)
  (print "Last Name: " last-name)
  (print "Email: " email)
  (print "Date of Birth: " dob "\n"))
    
