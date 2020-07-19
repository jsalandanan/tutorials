CircleRoom = Room:extend()

function CircleRoom:new(x, y, radius)
  CircleRoom.super.new(self)
  self.x = x
  self.y = y
  self.radius = radius
end

function CircleRoom:update(dt)
  CircleRoom.super.update(self, dt)
end

function CircleRoom:draw()
  CircleRoom.super.draw(self)
  love.graphics.circle('fill', self.x, self.y, self.radius)
end
