(with-dyn-lib "./lib/libaddition.so"
  (deffi add "add" int (int int)))

(prinl (add 1 2))
