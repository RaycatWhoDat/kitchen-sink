let error_csv = "\"Error\"\n\"No CSV found.\""

let () =
  let file_to_parse = if Array.length Sys.argv > 1 then Sys.argv.(1) else "." in
  let csv = try Csv.load file_to_parse
    with Sys_error _ -> Csv.input_all (Csv.of_string error_csv) in
  List.iter (fun row -> List.iter (Printf.printf "%s ") row; Printf.printf "\n") csv
