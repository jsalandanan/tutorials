Area = Object:extend()

function Area:new(room)
    self.room = room
    self.game_objects = {}
end

function Area:update(dt)
    for i = #self.game_objects, 1, -1 do
        local game_object = self.game_objects[i]
        game_object:update(dt)
        if game_object.dead then table.remove(self.game_objects, i) end
    end
end

function Area:draw()
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function Area:addGameObject(game_object_type, x, y, opts)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
    table.insert(self.game_objects, game_object)
    return game_object
end

function Area:getGameObjects(f)
  local objectsOfInterest = {}
  for _, gameObject in ipairs(self.game_objects) do
    if f(gameObject) then
      table.insert(objectsOfInterest, gameObject)
    end
  end
  return objectsOfInterest
end

function Area:queryCircleArea(x, y, radius, targetClasses)
  local withinObjects = {}
  local rSquared = radius^2

  for _, gameObject in ipairs(self.game_objects) do
    for _, targetClass in ipairs(targetClasses) do
      if gameObject:is(_G[targetClass]) then
        dSquared = (x - gameObject.x)^2 + (y - gameObject.y)^2
        if dSquared < rSquared then
          table.insert(withinObjects, gameObject)
        end
      end
    end
  end

  return withinObjects
end
