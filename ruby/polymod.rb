class Numeric
  def polymod *divisors
    running_total = self
    divisors.map do |divisor|
      result = running_total % divisor
      running_total = running_total / divisor
      result
    end << running_total
  end
end

p 120.polymod(10) # [0, 12]
p 120.polymod(10, 10) # [0, 2, 1]
p 120.polymod(10, 11) # [0, 1, 1]
p 120.polymod(11, 10) # [10, 0, 1]
p 97445.polymod(60, 60) # [5, 4, 27]
p 97445.polymod(60, 60, 24) # [5, 4, 3, 1]

