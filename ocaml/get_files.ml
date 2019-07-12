open Printf

module IgnoredPaths = Set.Make(String)

let ignored_paths =
  IgnoredPaths.(empty |> add ".git" |> add "target" |> add "dist" |> add "build" |> add "love" |> add "node_modules")
    
let rec get_files directory_path traversal_level =
  let current_listing = Sys.readdir directory_path in
  Array.iter (iterator directory_path traversal_level) current_listing
    
and is_directory directory_path entry traversal_level =
  let current_directory = directory_path ^ "/" ^ entry in
  if Sys.is_directory current_directory
  then get_files current_directory (traversal_level + 1)

and iterator directory_path traversal_level = fun entry ->
  printf "%.*s%s\n" (traversal_level * 2) "" entry;
  if not (IgnoredPaths.subset (IgnoredPaths.singleton entry) ignored_paths)
  then is_directory directory_path entry traversal_level
  else ()

let () =
  let desired_directory = if Array.length Sys.argv > 1 then Sys.argv.(1) else "." in
  get_files desired_directory 0
