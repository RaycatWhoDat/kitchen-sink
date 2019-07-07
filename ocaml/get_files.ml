let ignored_paths = [".git"; "target"; "dist"; "build"; "love"; "node_modules"]

let rec generate_indent indentation iterations =
  if iterations = 0 then "" else indentation ^ generate_indent indentation (iterations - 1)

let spacing = generate_indent " "

let rec get_files directory_path traversal_level =
  let current_listing = Array.to_list (Sys.readdir directory_path) in
  List.iter (iterator directory_path traversal_level) current_listing
    
and is_directory directory_path entry traversal_level =
  let current_directory = directory_path ^ "/" ^ entry in
  if Sys.is_directory current_directory
  then get_files current_directory (traversal_level + 1)

and iterator directory_path traversal_level = fun entry ->
  print_endline ((spacing traversal_level) ^ entry);
  if not (List.exists (fun path_to_ignore -> entry = path_to_ignore) ignored_paths)
  then is_directory directory_path entry traversal_level
  else ()

let () =
  let desired_directory = if Array.length Sys.argv > 1 then Sys.argv.(1) else "." in
  get_files desired_directory 0
