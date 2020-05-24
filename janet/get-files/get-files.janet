# -*- compile-command: "janet get-files.janet" -*-

(def *two-spaces* 2)
(def *ignored-paths* '(".git" "dist" "_dub" "target" "love" "node_modules"))

(defn member
  "Given ARR is an array-like structure, return TRUE if TARGET is found in the array."
  [arr item]
  (some (partial = item) arr))

(defn get-files
  "Get all the files in DIRECTORY-PATH recursively."
  [&opt directory-path traversal-level]
  (default directory-path ".")
  (default traversal-level 0)

  (each file (sort (os/dir directory-path))
    (print (string (string/repeat " " (* *two-spaces* traversal-level)) file))
    (when (and
            (= (os/stat (string/join @[directory-path file] "/") :mode) :directory)
            (not (member *ignored-paths* file)))
      (get-files (string/join @[directory-path file] "/") (+ traversal-level 1)))))

(defn main [& args]
  (if (> (length args) 1)
    (get-files (last args))
    (get-files)))
