(defvar *name* nil)

(while (zerop (length *name*))
  (pprint "What's your name? ")
  (set *name* (trim-str (get-line *stdin*)))
  (when (zerop (length *name*))
    (pprinl "Please enter a name.")))

(pprinl (join "Hello, " *name* ", nice to meet you."))
(pprinl (join *name* " is " (tostring (length *name*)) " characters long."))
