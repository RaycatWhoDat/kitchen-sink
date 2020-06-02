(defn test-func []
  (print "Hi from the test function!")
  (print 1 2 3 4))

(defn run-all []
  (print "Hello from Janet!")
  (test-func))

(run-all)
