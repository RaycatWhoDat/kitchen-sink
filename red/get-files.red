-*- mode: red; compile-command: "./red get-files.red"; eval: (setq tab-width 2)  -*-

Red []

ignored-paths: [".git/" "node_modules/" "target/" "love/" ".dub/"]

get-files: function [
  "This takes a directory path."
  current-directory [file! string!] "The directory path."
  file-level [integer!] "The current indentation level."
][
  listing: read to-red-file current-directory
  
  foreach entry listing [
    repeat counter (file-level * 2) [prin " "]
    if (find ignored-paths (make string! entry)) <> none [continue]
    print entry
    if dir? entry [get-files rejoin [current-directory "/" entry] file-level + 1]
  ]
]

get-files ".." 0
