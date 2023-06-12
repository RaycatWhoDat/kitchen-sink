function split_file_path(filename)
   return string.match(filename, "(.-[^\\/]-)%.([^\\/]+)$")
end

do
   local test_cases = {
      "C:\\Users\\TestUser\\Documents\\MyFile.zip",
      "C:\\Users\\TestUser\\Documents\\MyFile2.tar.gz",
      "C:\\Users\\TestUser\\Documents\\MyFile3.tar.bz2.gz",
      "/home/testuser/Desktop/MyFile4.zip",
      "/home/testuser/Desktop/MyFile5.tar.gz",
      "/home/testuser/Desktop/MyFile6.tar.bz2.gz"
   }
   
   for _, test_case in ipairs(test_cases) do
      print(split_file_path(test_case))
   end

   --[[
      C:\Users\TestUser\Documents\MyFile	zip
      C:\Users\TestUser\Documents\MyFile2	tar.gz
      C:\Users\TestUser\Documents\MyFile3	tar.bz2.gz
      /home/testuser/Desktop/MyFile4	zip
      /home/testuser/Desktop/MyFile5	tar.gz
      /home/testuser/Desktop/MyFile6	tar.bz2.gz
   ]]
end
