local fp = assert(io.popen("ls"))
local line = fp:read("*l")
while line do
  print(line)
  line = fp:read("*l")
end
return nil
