(fn pp [value]
  (print ((. (require :fennel) :view) value)))

(fn comb [string]
  (icollect [char (string.gmatch string ".")] char))

(fn Bag [t]
  (let [res {}]
    (each [_ item (ipairs t)]
      (when (not (. res item)) (tset res item 0))
      (tset res item (+ (. res item) 1)))
    res))

{
  :Bag Bag
  :comb comb
  :pp pp
}
