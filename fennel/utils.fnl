(fn pp [value] (print ((. (require :fennel) :view) value)))

{:pp pp}
