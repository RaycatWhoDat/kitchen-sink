(defmacro cross (list1 list2)
  `(loop for item1 in ,list1 collect (loop for item2 in ,list2 collect (,item1 ,item2))))

(let ((qualities '("Wood" "Copper" "Bronze" "Iron" "Silver" "Steel" "Gold" "Rune"))
       (weapons '("Knife" "Dagger" "Short Sword" "Sword" "Longsword" "Zweihander" "Shield")))
  (cross qualities weapons))
