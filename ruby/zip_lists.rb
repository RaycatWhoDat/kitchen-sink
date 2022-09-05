list1 = 1..5
list2 = 5..10
list3 = 10..15

list1.zip(list2, list3).each do |(item1, item2, item3)|
  puts "#{item1}, #{item2}, #{item3}"
end
