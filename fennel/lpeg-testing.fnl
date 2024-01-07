(local {: P : S : R : V : C : Ct :match lmatch } (require :lpeg))

(local patt
  (P {
       1 :TOP
       :TOP (* (P "a") (C (^ (P "b") 1)) (P "c"))
       }))

(each [_ test-case (ipairs ["abbbbb" "a" "abc" "abbbbbbbbbbbbbbbc"])]
  (print (lmatch patt test-case)))
    
              
