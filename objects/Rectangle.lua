Rectangle = GameObject:extend()

function Rectangle:new(area, x, y, opts)
  Rectangle.super.new(self, area, x, y, opts)
  self.creation_time = love.timer.getTime()
  self.width = love.math.random(1, 100)
  self.height = love.math.random(1, 100)
end

function Rectangle:update(dt)
  Rectangle.super.update(self, dt)
end

function Rectangle:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end
