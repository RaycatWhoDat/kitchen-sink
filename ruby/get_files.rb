Dir.glob("../**/**").each do |listing|
  path_parts = listing.split("/")[1..]
  printf("  " * (path_parts.length - 1) + "%s\n", path_parts.last) 
end

