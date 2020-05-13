# -*- compile-command: "janet get-files.janet" -*-

(def TWO_SPACES 2)
(def ignored-paths '(".git" "dist" "_dub" "target" "love" "node_modules"))

(defn in-list
  "Given ARR is an array-like structure, return TRUE if ITEM is found in the array."
  [arr target]
  (var found false)
  (loop [item :in arr :when (= item target)] (set found true))
  found)

(defn get-files
  "Get all the files in DIRECTORY-PATH recursively."
  [&opt traversal-level directory-path]
  (default traversal-level 0)
  (default directory-path ".")
  (each file (sort (os/dir directory-path))
    (print (string (string/repeat " " (* TWO_SPACES traversal-level)) file))
    (when (and
            (= (os/stat (string/join @[directory-path file] "/") :mode) :directory)
            (not (in-list ignored-paths file)))
      (get-files (+ traversal-level 1) (string/join @[directory-path file] "/")))))

(defn main [& args]
  (get-files 0 ".."))
