Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
EnhancedTimer = require 'libraries/EnhancedTimer/EnhancedTimer'
M = require 'libraries/Moses/moses'

require('objects/Room')
require('objects/CircleRoom')
require('objects/RectangleRoom')
require('objects/PolygonRoom')



function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    current_room = nil

    roomInput = Input()
    roomInput:bind('f1', 'circleRoom')
    roomInput:bind('f2', 'rectangleRoom')
    roomInput:bind('f3', 'polygonRoom')

end

function love.update(dt)
    if current_room then current_room:update(dt) end

    if roomInput:down('circleRoom') then
        gotoRoom('CircleRoom', 400, 300, 25)
    elseif roomInput:down('rectangleRoom') then
        gotoRoom('RectangleRoom', 400, 300, 40, 20)
    elseif roomInput:down('polygonRoom') then
        gotoRoom('PolygonRoom', {100, 100, 200, 100, 150, 200})
    end
end

function love.draw()
    if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
    print(_G[room_type])
    current_room = _G[room_type](...)
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

