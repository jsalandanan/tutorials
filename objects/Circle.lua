Circle = GameObject:extend()

function Circle:new(area, x, y, opts)
  Circle.super.new(self, area, x, y, opts)
  self.creation_time = love.timer.getTime()
  self.lifespan = love.math.random(2, 4)

  self.timer:after(self.lifespan, function() self.dead = true end)
end

function Circle:update(dt)
  Circle.super.update(self, dt)
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)

end
