IO.read("../d/MOCK_DATA.csv").lines(chomp: true).each do |line|
  line =~ /([^,\n]+),([^,\n]+),([^,\n]+),([^,\n]+)/;
  puts "#{$1}, #{$2}, #{$3}, #{$4}"
end
