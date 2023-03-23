(local Rx (require :rx))

(-> (Rx.Observable.fromRange 1 10)
  (: :filter (fn [item] (= (% item 2) 0)))
  (: :map (fn [value] (.. value value)))
  (: :filter (fn [item] ((. (require :pl.stringx) :isdigit) item)))
  (: :subscribe print))

