package main

import "core:fmt"
import "core:os"
import "core:strings"

get_files :: proc (directory: string, file_level: int = 0) {
  using os

  files: []File_Info

  if dir_handle, errno := open(directory); errno == 0 {
    files, _ = read_dir(dir_handle, 0)
  }

  ignored_files := [?]string {
    ".git",
    ".gitattributes",
    ".gitignore",
    "love",
    "target",
    "node_modules",
    "dist"
  }
  
  for file in files {
    is_valid := true
    
    for ignored_file in ignored_files {
      if file.name == ignored_file {
	is_valid = false
	break
      }
    }

    if !is_valid {
      return
    }
    
    fmt.printf("%s%s\n", strings.repeat(" ", file_level * 2), file.name)
    
    if is_dir(file.fullpath) {
      get_files(file.fullpath, file_level + 1)
    }
  }
}

main :: proc () {
  get_files("..")
}
