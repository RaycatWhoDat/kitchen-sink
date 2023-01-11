Class = {}
function Class.new(new_self, new_obj)
   new_self.__index = new_self
   return setmetatable(new_obj, new_self)
end

return Class
