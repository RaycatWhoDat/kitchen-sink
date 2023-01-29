function get_percentage_bar(percentage)
   assert((percentage >= 0.0) and (percentage <= 1.0), "Percentage must be between 0 and 1.")
   return string.rep("🔴", math.floor(percentage * 10)) .. string.rep("⭕", 10 - math.floor(percentage * 10))
end

print(get_percentage_bar(0.5))
