Circle = Object:extend()

function Circle:new(x, y, radius)
  newObj = {}
  setmetatable(newObj, self)
  self.__index = self
  self.x = x
  self.y = y
  self.radius = radius
  self.creation_time = love.timer.getTime()
  return newObj
end

function Circle:update(dt)

end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)

end
