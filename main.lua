Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
EnhancedTimer = require 'libraries/EnhancedTimer/EnhancedTimer'

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    input = Input()
    input:bind('s', 'shrink')
    input:bind('e', 'expand')
    timer = EnhancedTimer()
    circle = {radius = 24}

end
function love.update(dt)
    timer:update(dt)
    if input:pressed('shrink') then
        timer:tween('shrink-tag', 3, circle, {radius=24}, 'in-out-cubic')
    end 
    if input:pressed('expand') then
        timer:tween('expand-tag', 3, circle, {radius=96}, 'in-out-cubic')
    end
end

function love.draw()
    love.graphics.circle('fill', 400, 300, circle.radius)
    love.graphics.print(circle.radius)
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
