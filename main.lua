Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
EnhancedTimer = require 'libraries/EnhancedTimer/EnhancedTimer'

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    timer = Timer()
    rect_1 = {x = 400, y = 300, w = 50, h = 200}
    rect_2 = {x = 400, y = 300, w = 200, h = 50}
    timer:tween(1, rect_1, {x = 400, y = 300, w = 0, h = 200}, 'in-out-cubic',
    function() timer:tween(1, rect_2, {x = 400, y = 300, w = 200, h = 0}, 'in-out-cubic',
        function()
            timer:tween(2, rect_1, {x = 400, y = 300, w = 50, h = 200}, 'in-out-cubic')
            timer:tween(2, rect_2, {x = 400, y = 300, w = 200, h = 50},'in-out-cubic')
        end)
    end)
end

function love.update(dt)
  timer:update(dt)
end

function love.draw()
    love.graphics.rectangle('fill', rect_1.x - rect_1.w/2, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
    love.graphics.rectangle('fill', rect_2.x - rect_2.w/2, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)
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
