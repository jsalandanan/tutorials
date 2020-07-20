PolygonRoom = Room:extend()

function PolygonRoom:new(vertices)
  PolygonRoom.super.new(self)
  self.vertices = vertices
end

function PolygonRoom:update(dt)
  PolygonRoom.super.update(self, dt)
end

function PolygonRoom:draw()
  PolygonRoom.super.draw(self)
  love.graphics.polygon('fill', self.vertices)
end
