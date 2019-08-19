# -*- compile-command: "janet get-files.janet" -*-

(def ignored-paths '(".git" "dist" "_dist" "target" "node_modules" "love" ".dub"))

(defn in/list [needle haystack]
  (var result false)
  (each item haystack
    (when (= item needle)
      (set result true)))
    result)

(defn get-files
  [directory-path traversal-level]
  "Prints out the files recursively."
  (each filename (os/dir directory-path)
    (print (string/repeat " " (* traversal-level 2)) filename)
    (when (and (= (get (os/stat (string directory-path "/" filename)) :mode) :directory)
               (not (in/list filename ignored-paths)))
      (get-files (string directory-path "/" filename) (+ traversal-level 1)))))

(defn main [& args]
  (get-files ".." 0))
