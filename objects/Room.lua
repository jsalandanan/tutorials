Room = Object:extend()

function Room:new()
  newObj = {}
  setmetatable(newObj, self)
  self.__index = self
  return newObj
end

function Room:update(dt)

end

function Room:draw()
end