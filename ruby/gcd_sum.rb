puts (1..100).to_a.combination(2).uniq.map { |pair| pair.inject(:gcd) }.sum
