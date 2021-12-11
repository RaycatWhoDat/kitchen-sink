(with-dyn-lib "./quick-math/target/debug/libquick_math.so"
  (deffi add "add" float (float float))
  (deffi subtract "subtract" float (float float))
  (deffi multiply "multiply" float (float float))
  (deffi divide "divide" float (float float)))

(prinl (divide (subtract (multiply (add 1 2) 3) 1) 2))

