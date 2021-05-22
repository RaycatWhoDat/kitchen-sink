(defvar name nil)

(while (zerop (length name))
  (pprint "What's your name? ")
  (set name (trim-str (get-line *stdin*)))
  (when (zerop (length name))
    (pprinl "Please enter a name.")))

(pprinl `Hello, @name, nice to meet you.`)
(pprinl `@name is @(tostring (length name)) characters long.`)
