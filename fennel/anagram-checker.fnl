(local pp (. (require :utils) :pp))
(local comb (. (require :utils) :comb))
(local Bag (. (require :utils) :Bag))
(local tablex (require :pl.tablex))
(local test (require :pl.test))

(fn check-anagrams [word possible-anagrams]
  (local result [])
  (each [_ anagram (ipairs possible-anagrams)]
    (when (tablex.deepcompare (Bag (comb anagram)) (Bag (comb word)))
      (table.insert result anagram)))
  result)

(test.asserteq (check-anagrams "abba" ["abba"]) ["abba"])
(test.asserteq (check-anagrams "abba" ["abbba"]) [])
(test.asserteq (check-anagrams "abba" ["abca"]) [])
(test.asserteq (check-anagrams "abba" ["baab"]) ["baab"])
(test.asserteq (check-anagrams "abba" ["aabb" "abcd" "bbaa" "dada"]) ["aabb" "bbaa"])
(test.asserteq (check-anagrams "racer" ["crazer" "carer" "racar" "caers" "racer"]) ["carer" "racer"])
(test.asserteq (check-anagrams "laser" ["lazing" "lazy" "lacer"]) [])

