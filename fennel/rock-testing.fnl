(local Rx (require :rx))

(local data (require :pl.data))
(local pretty (require :pl.pretty))
(local stringx (require :pl.stringx))
(stringx.import)

(-> (Rx.Observable.fromRange 1 10)
  (: :filter (fn [item] (= (% item 2) 0)))
  (: :map (fn [value] (.. value value)))
  (: :filter (fn [item] (stringx.isdigit item)))
  (: :subscribe print))

(let [data (data.read "../d/MOCK_DATA.csv")]
  (each [row (data:select_row "*")]
    (pretty.dump row)))

