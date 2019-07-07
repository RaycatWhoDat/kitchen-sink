(* Let's try to do some function composition in OCaml. *)

let rec range first last = if first >= last then [] else first :: (range (first + 1) last);;

let add1 x = x + 1;;
let subtract3 x = x - 3;;
let multiply4 x = x * 4;;
let divide2 x = x / 2;;
let print_result x = print_endline (string_of_int x);;

let print_results_of list_to_iterate =
  List.iter (fun x ->
      x
      |> add1
      |> subtract3
      |> multiply4
      |> divide2
      |> print_result)
  list_to_iterate
;;

range 0 30 |> print_results_of;;

(* Add a reducer later on. *)
