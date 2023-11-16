(local List (require :pl.List))
(local permute (require :pl.permute))
(local stringx (require :pl.stringx))

(print
  (-> (List.range 1 10)
    (: :reduce (fn [acc item] (+ acc item))))) 

(let [test_case (icollect [char (string.gmatch "abcd" ".")] char)]
  (each [perm (permute.order_iter test_case)]
    (print (stringx.join "" perm))))
