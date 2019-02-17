local lfs = require('lfs')
local indent_width = 4
local max_file_level = -1
local ignored_paths = { '.', '..', '.git', 'node_modules' };

function is_ignored_path(path_name)
   for _, ignored_path in pairs(ignored_paths) do
      if path_name == ignored_path then return true end
   end
   return false
end

function generate_indent(max_file_level)
   local indent = '';
   for file_level = 0, max_file_level, 1 do
      for width = 1, indent_width, 1 do
         indent = indent .. ' '
      end
   end
   return indent
end

function print_file_name(file_name)
   if is_ignored_path(file_name) then return end
   print(generate_indent(max_file_level) .. file_name)
   assert(lfs.attributes(file_name, 'mode') ~= nil)
   if lfs.attributes(file_name, 'mode') == 'directory' then
      return print_files_recursively(file_name)
   else
      return file_name
   end
end

function print_files_recursively(directory_name)
   max_file_level = max_file_level + 1
   local current_directory = directory_name ~= nil and directory_name or lfs.currentdir()
   lfs.chdir(current_directory)
   for file_name in lfs.dir(lfs.currentdir()) do
      -- print(lfs.currentdir(), file_name)
      print_file_name(file_name)
   end
   lfs.chdir('..')
   max_file_level = max_file_level - 1
   if max_file_level < 0 then
      os.exit()
   end
end

print_files_recursively()
