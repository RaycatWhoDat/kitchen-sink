local InputRange = {
   frontIndex = 1,
   backIndex = 1,
   keys = {}
   values = {}
}

function InputRange:new(obj)
   obj = obj or {}
   local newRange = setmetatable(obj, self)
   self.__index = self
   return newRange
end

function InputRange:isEmpty()
   return self.frontIndex > self.backIndex or self.backIndex < self.frontIndex
end

function InputRange:front()
   return self.values[self.keys[self.frontIndex]]
end

function InputRange:popFront()
   self.frontIndex = self.frontIndex + 1
end

local ForwardRange = InputRange:new({ saved = {} })

function ForwardRange:save()
   self.saved = self.keys
   return self
end

local BidirectionalRange = ForwardRange:new()

function BidirectionalRange:back()
   return self.values[self.keys[self.backIndex]]
end

function BidirectionalRange:popBack()
   self.backIndex = self.backIndex - 1
end

local RandomAccessRange = ForwardRange:new({ length = 0 })
