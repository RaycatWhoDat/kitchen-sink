package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:sort"

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

  sort.quick_sort_proc(files, proc (file1, file2: File_Info) -> int {
    return strings.compare(file1.name, file2.name)
  })
  
  for file in files {
    is_ignored := false
    
    for ignored_file in ignored_files {
      if file.name == ignored_file {
	is_ignored = true
	break
      }
    }

    if is_ignored {
      continue
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
