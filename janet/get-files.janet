# -*- compile-command: "janet test.janet" -*-

(defn get-files
  "Prints out the files recursively."
  [directory-path traversal-level]
  (each filename (os/dir directory-path)
    (print (string/repeat " " (* traversal-level 2)) filename)
    (when (= (get (os/stat (string directory-path "/" filename)) :mode) :directory)
      (get-files (string directory-path "/" filename) (+ traversal-level 1)))))

(get-files ".." 0)


