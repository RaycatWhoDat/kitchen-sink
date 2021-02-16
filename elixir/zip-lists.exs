test_case1 = Enum.to_list 1..100
test_case2 = Enum.reverse test_case1
IO.inspect List.zip([test_case1, test_case2]), label: "The list is"
