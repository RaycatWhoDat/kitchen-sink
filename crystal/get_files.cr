current_directory = Dir.new(".")
while entry = current_directory.read
  puts entry if entry != "." && entry != ".."
end


