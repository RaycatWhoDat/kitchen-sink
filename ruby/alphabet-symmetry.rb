def count_symmetric_characters words
  words.map do |word|
    count = 0
    word.downcase.chars.each_with_index do |letter, index|
      count += 1 if index == letter.ord - 97
    end
    count
  end
end

p count_symmetric_characters %w[abode ABc xyzD]
