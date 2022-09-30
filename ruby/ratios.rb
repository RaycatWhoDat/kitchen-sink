NUMBER_OF_ITEMS = 100
ratios = NUMBER_OF_ITEMS.times.map { [-1, 0, 1].sample }.tally
ratios.each_pair { |key, value| puts "#{key}: #{value / 100.0}" }

