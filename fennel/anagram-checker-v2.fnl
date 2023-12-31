(local pp (. (require :utils) :pp))
(local Bag (. (require :utils) :Bag))
(local comb (. (require :utils) :comb))
(local M (require :moses))

(fn check-anagrams [word possible-anagrams]
  (let [result []]
    (each [_ anagram (ipairs possible-anagrams)]
      (when (M.isEqual
              (->
                (comb word)
                (M.chain)
                (: :countBy string.lower)
                (: :value))
              (->
                (comb anagram)
                (M.chain)
                (: :countBy string.lower)
                (: :value)))
        (table.insert result anagram)))))

(when (M.allEqual [(M.isEqual (check-anagrams "abba" ["abba"]) ["abba"])
                  (M.isEqual (check-anagrams "abba" ["abbba"]) [])
                  (M.isEqual (check-anagrams "abba" ["abca"]) [])
                  (M.isEqual (check-anagrams "abba" ["baab"]) ["baab"])
                  (M.isEqual (check-anagrams "abba" ["aabb" "abcd" "bbaa" "dada"]) ["aabb" "bbaa"])
                  (M.isEqual (check-anagrams "racer" ["crazer" "carer" "racar" "caers" "racer"]) ["carer" "racer"])
                  (M.isEqual (check-anagrams "laser" ["lazing" "lazy" "lacer"]) [])])
  (print "All tests passed."))
