RectangleRoom = Room:extend()

function RectangleRoom:new(x, y, w, h)
  RectangleRoom.super.new(self)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
end

function RectangleRoom:update(dt)
  RectangleRoom.super.update(self, dt)
end

function RectangleRoom:draw()
  RectangleRoom.super.draw(self)
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
