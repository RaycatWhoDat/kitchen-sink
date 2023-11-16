(each ((combination (perm (split-str "abc" ""))))
  (pprinl (join combination)))
